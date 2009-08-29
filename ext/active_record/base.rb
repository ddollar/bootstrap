class ActiveRecord::Base

  def self.bootstrap(record, keys=nil)
    keys ||= [:id]
    keys   = [keys] if keys.is_a? Symbol

    keys.each do |key|
      raise "Data must contain key: #{key}" unless record.keys.include?(key)
    end

    key_values = keys.sort.map do |key|
      value = record[key]
      value = "<#{value.class}:#{value.id}>" if value.is_a?(ActiveRecord::Base)
      [ key, value ].join(':')
    end.join(' ')

    puts '%15s [%s]' % [ self.to_s.humanize, key_values]

    columns = self.columns.map(&:name)

    conditions = keys.inject({}) do |memo, key|
      real_key = columns.include?("#{key}_id") ? "#{key}_id" : key
      memo.update({ real_key => record[key] })
    end

    records = self.find(:all, :conditions => conditions)

    raise 'Keys matched more than one record' unless records.length < 2

    if records.empty?
      self.create!(record)
    else
      records.first.update_attributes!(record)
    end
  end

end
