# frozen_string_literal: true

# Метод отбирающий доступные лицензии
def available_versions(paid_till, max_version, min_version, flussonic_last_version)
  array = []
  paid_till = paid_till.slice(paid_till.size - 2, paid_till.size - 1).to_i + paid_till.split('.')[1].to_i / 100.0
  max_version = 100 if max_version.nil?
  min_version = 0 if min_version.nil?
  max = max_version <= paid_till ? max_version : paid_till
  i = 0
  while flussonic_last_version >= min_version && i < 5
    if flussonic_last_version <= max
      array.unshift(flussonic_last_version)
    end

    flussonic_last_version = if flussonic_last_version * 100 % 100 == 1
                               flussonic_last_version - 0.89
                             else
                               flussonic_last_version - 0.01
                             end

    i += 1
  end

  if array.empty?
    if max_version == 100
      return nil
    else
      return array << max_version
    end
  end

  array.map { |elem| elem.round(2) }
end

# Генерация входных значений
paid_till = "#{rand(1..28)}.#{rand(1..12)}.20#{rand(15..24)}"

max_version = (rand(15..24) + rand(1..12) / 100.0 if rand(2) == 1)

if rand(2) == 1
  min_version = if max_version
                  max_version.to_i - rand(5) - 1 + rand(1..12) / 100.0
                else
                  paid_till.slice(paid_till.size - 2, paid_till.size - 1).to_i - rand(5) - 1 + rand(1..12) / 100.0
                end
else
  min_version = nil
end

time = Time.now

flussonic_last_version = time.year.to_s.slice(2, 3).to_i + time.month / 100.0

# Вывод входных значений и результата работы метода
print("paid_till: #{paid_till}\nmax_version: #{max_version}\nmin_version: #{min_version}\nFlussonicLastVersion.get: #{flussonic_last_version}\n")
print("Доступные лицензии: #{available_versions(paid_till, max_version, min_version, flussonic_last_version)}\n")
