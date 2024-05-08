module Bdd

    require 'pg'

    def connexion_bdd
        begin
            conn = PG.connect(dbname: 'bd', user: 'due', password: 'postgres', host: 'localhost', port: '5432')
            puts "connexion à la base de donnée réussi"
            return conn
        rescue PG::Error => e
            puts "Erreur lors de la connexion à la base de données : #{e.message}"
            exit
        end
    end

    def insert_data(conn, table_name, data)
        columns = data.first.keys.join(",")
        values = data.map { |row| "(#{row.values.map { |value| "'#{value}'" }.join(",")})" }.join(",")
        conn.exec("INSERT INTO #{table_name} (#{columns}) VALUES #{values}")
    end

end