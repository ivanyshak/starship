class FuelCalculator
  def initialize(mass, args)
    @args = args
    @mass = mass
    @counter = 0
  end

  attr_accessor :mass, :args

  def launch_result
    return 'Thre is no mass data' if valid_data?(mass)
    return 'Thre is no gravity data' if valid_data?(launch_data)

    launch_calculate(mass, launch_data).round(2)
  end

  def landing_result
    return 'Thre is no mass data' if valid_data?(mass)
    return 'Thre is no gravity data' if valid_data?(land_data)

    landing_calculate(mass, land_data).round(2)
  end

  private

  def launch_calculate(mass, gravity)
    fuel_mass = (mass * launch_data * 0.042 - 33).to_i

    @counter += fuel_mass
    return @counter if fuel_mass <= 40

    launch_calculate(fuel_mass, gravity)
  end

  def landing_calculate(mass, gravity)
    fuel_mass = (mass * land_data * 0.033 - 42).to_i

    @counter += fuel_mass
    return @counter if fuel_mass <= 40

    landing_calculate(fuel_mass, gravity)
  end

  def valid_data?(param)
    param <= 0
  end

  def launch_data
    convert_to_hash[:launch].sum
  end

  def land_data
    convert_to_hash[:land].sum
  end

  def convert_to_hash
    args.each_with_object(Hash.new{ |h, k| h[k] = [] }) { |(k, v), h| h[k] << v }
  end
end
