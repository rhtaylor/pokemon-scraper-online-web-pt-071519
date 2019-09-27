class Pokemon
  attr_accessor :name, :type, :db
  attr_reader :id

  def initialize(id: nil, name:, type:, db:)
    @id = id
    @name = name
    @type = type
    @db = db
  end

  def self.save(name, type, db)

    sql = <<-POKE
    INSERT INTO pokemon (name, type) VALUES (?, ?)
              POKE
  db.execute(sql, name, type)
  end

  def self.find(num, db)
    sql = <<-WOW
    SELECT * FROM pokemon WHERE id = ? LIMIT 1
            WOW
    db.execute(sql, num).map do |poke|
      poke
      pokemon = Pokemon.new(poke[0], nil, nil)
      pokemon.name = poke[1]
      pokemon.type = poke[2]
      pokemon
    end.first
  end
end
