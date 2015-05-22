class Statement

  attr_accessor :sql, :limit, :offset, :extended, :parameters

  def initialize(h)
    h.each do |k,v|
      if k == :parameters
        self.parameters = v.collect { |p| Parameter.new p }
      else
        send "#{k}=", v
      end
    end
  end

  def validate_parameters
    placeholders = sql.scan(/\s\:(\w+)\b/).uniq.map {|m| m[0]}
    placeholders.each do |placeholder|
      unless parameters.select {|p| p.name == placeholder } != []
        # errors.add(:parameters, "you must define #{placeholder} in your parameters list")
        return false
      end
    end
    true
  end

  def sanitize
    sql.gsub!(/(--.*)/,"")
    sql.gsub!(/([\n|\t])/,"\s")
    sql.gsub!(/\s+/,"\s")
    fix_time_functions
    sql.strip!
  end

  def bind
     if validate_parameters
      parameters.each do |parameter|
        sql.gsub!(/(\:#{parameter.name})\b/,parameter.value.to_s)
      end
    end
  end

  def prepare
    sanitize
    bind
    set_limit
    puts sql
  end

  protected

    def fix_time_functions()
      fix_curdate
      fix_curtime
      fix_curtimestamp
    end

    def fix_curdate()
      sql.gsub!(/(\{\s*fn\s+(?:curdate|current_date)\s*\(\s*\)\s*\})/i,"{D '#{Time.now.strftime '%Y-%m-%d'}'}")
    end

    def fix_curtime()
      sql.gsub!(/(\{\s*fn\s+(?:curtime|current_time)\s*\(\s*\)\s*\})/i,"{T '#{Time.now.strftime '%H:%M:%S'}'}")
    end

    def fix_curtimestamp()
      sql.gsub!(/(\{\s*fn\s+(?:curtimestamp|current_timestamp)\s*\(\s*\)\s*\})/i,"{TS '#{Time.now.strftime '%Y-%m-%d %H:%M:%S'}'}")
    end

    def set_limit
      if limit_clause
        matches = limit_clause.scan(/LIMIT\s+(\d+|ALL).*/i)
        limit = (matches and matches[0]) ? matches[0][0] : '0'
        if 'ALL' == limit.upcase
          self.limit = Float::INFINITY
        else
          self.limit = limit.to_i
        end
        matches = limit_clause.scan(/LIMIT\s+(?:\d+|ALL)\s+OFFSET\s+(\d+)/i)
        self.offset = (matches and matches[0]) ? matches[0][0].to_i : 0
      end
      sql.gsub!(/\b(LIMIT\b.*)/i,"")
    end

    def limit_clause
      matches = sql.scan(/\b(LIMIT\b.*)/i)
      if matches and matches[0]
        @limit_clause ||= matches[0][0]
      else
        self.limit = 0
        self.offset = 0
      end
      @limit_clause
    end
end