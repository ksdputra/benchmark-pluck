def extract_(record)
  {
    first_name: record[0],
    last_name: record[1],
    nick_name: record[2],
    email: record[3],
    phone_number: record[4],
    age: record[5],
    company: record[6],
    position: record[7],
    role: record[8],
    status: record[9],
    character: record[10],
    reward: record[11],
    level: record[12],
    quote: record[13],
    money: record[14],
    marital: record[15],
    product: record[16],
    food: record[17],
    drink: record[18],
    laptop: record[19]
  }
end

def array_of_records
  records = []
  CSV.read("lib/data/seed150000.csv").each do |record|
    records << extract_(record)
  end
  records
end

User.insert_all(array_of_records)