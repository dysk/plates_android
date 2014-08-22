# encoding: utf-8

class PlatesRepository
  NotFound = Class.new(StandardError)

  def find_by_prefix(prefix)
    return get_result(prefix.upcase)
  rescue KeyError
    raise NotFound
  end

  private

  def get_result(prefix)
    @plates ||= {
      'PO' => 'Poznań',
      'DW' => 'Wrocław',
      'GD' => 'Gdańsk',
      'EL' => 'Łódź',
      'KR' => 'Kraków',
    }
    return @plates.fetch(prefix)
  end
end

