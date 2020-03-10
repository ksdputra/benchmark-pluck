require 'benchmark'
require 'benchmark/memory'
require 'benchmark/ips'

class Benchmarking
  def call
    puts "User count: #{User.count}\n"
    puts "\n1st Benchmarking (computation time)..."
    Benchmark.bmbm do |x|
      x.report("map") { mapping }
      x.report("pluck") { is_pluck }
      x.report("pluck + map") { is_pluck_map }
      x.report("pluck_all") { is_pluck_all }
      x.report("pluck_to_hash ") { is_pluck_to_hash }
    end
    puts "\n2nd Benchmarking (iteration per second)..."
    Benchmark.ips do |x|
      x.config(time: 2, warmup: 1)

      x.report("map") { mapping }
      x.report("pluck") { is_pluck }
      x.report("pluck + map") { is_pluck_map }
      x.report("pluck_all") { is_pluck_all }
      x.report("pluck_to_hash ") { is_pluck_to_hash }

      x.compare!
    end
    puts "\n3rd Benchmarking (memory allocation)..."
    Benchmark.memory do |x|
      x.report("map") { mapping }
      x.report("pluck") { is_pluck }
      x.report("pluck + map") { is_pluck_map }
      x.report("pluck_all") { is_pluck_all }
      x.report("pluck_to_hash ") { is_pluck_to_hash }

      x.compare!
    end
  end

  def mapping
    users = User.all
    result = []
    users.each do |user|
      result << {
        id: user.id,
        first_name: user.first_name,
        last_name: user.last_name,
        nick_name: user.nick_name,
        email: user.email,
        phone_number: user.phone_number,
        age: user.age,
        company: user.company,
        position: user.position,
        role: user.role,
        status: user.status,
        character: user.character,
        reward: user.reward,
        level: user.level,
        quote: user.quote,
        money: user.money,
        marital: user.marital,
        product: user.product,
        food: user.food,
        drink: user.drink,
        laptop: user.laptop
      }
    end
    return result
  end

  def is_pluck
    User.all.pluck(
      :id,
      :first_name,
      :last_name,
      :nick_name,
      :email,
      :phone_number,
      :age,
      :company,
      :position,
      :role,
      :status,
      :character,
      :reward,
      :level,
      :quote,
      :money,
      :marital,
      :product,
      :food,
      :drink,
      :laptop
    )
  end

  def is_pluck_map
    User
    .all
    .pluck(
      :id,
      :first_name,
      :last_name,
      :nick_name,
      :email,
      :phone_number,
      :age,
      :company,
      :position,
      :role,
      :status,
      :character,
      :reward,
      :level,
      :quote,
      :money,
      :marital,
      :product,
      :food,
      :drink,
      :laptop
    )
    .map do |id, first_name, last_name, nick_name, email, phone_number, age, company, position, role, status, character, reward, level, quote, money, marital, product, food, drink, laptop| 
      {
        id: id,
        first_name: first_name,
        last_name: last_name,
        nick_name: nick_name,
        email: email,
        phone_number: phone_number,
        age: age,
        company: company,
        position: position,
        role: role,
        status: status,
        character: character,
        reward: reward,
        level: level,
        quote: quote,
        money: money,
        marital: marital,
        product: product,
        food: food,
        drink: drink,
        laptop: laptop
      }
    end
  end

  def is_pluck_all
    User.all.pluck_all(
      :id,
      :first_name,
      :last_name,
      :nick_name,
      :email,
      :phone_number,
      :age,
      :company,
      :position,
      :role,
      :status,
      :character,
      :reward,
      :level,
      :quote,
      :money,
      :marital,
      :product,
      :food,
      :drink,
      :laptop
    )
  end
  
  def is_pluck_to_hash
    User.all.pluck_to_hash(
      :id,
      :first_name,
      :last_name,
      :nick_name,
      :email,
      :phone_number,
      :age,
      :company,
      :position,
      :role,
      :status,
      :character,
      :reward,
      :level,
      :quote,
      :money,
      :marital,
      :product,
      :food,
      :drink,
      :laptop
    )
  end
  
end