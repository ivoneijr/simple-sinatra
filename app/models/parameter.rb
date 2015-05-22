class Parameter

  attr_accessor :name, :value, :type, :evaluated

  def initialize(h)
    h.each {|k,v| send("#{k}=",v)}
    evaluate
    formmat
  end

  def evaluate
    if evaluated
      self.value = eval(value)
    end
  end

  def formmat
    if type == 'date' and evaluated
      self.value = value.strftime("%Y-%m-%d")
    end
    if type == 'time' and evaluated
      self.value = value.strftime("%H:%M:%S")
    end
    if type == 'timestamp' and evaluated
      self.value = value.strftime("%Y-%m-%d %H:%M:%S")
    end
    if type == 'varchar'
      self.value = "'#{value}'"
      return
    end
    if type == 'date'
      self.value = "{D '#{value}'}"
      return
    end
    if type == 'time'
      self.value = "{T '#{value}'}"
      return
    end
    if type == 'timestamp'
      self.value = "{TS '#{value}'}"
      return
    end
  end

end