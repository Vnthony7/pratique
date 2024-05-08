#!/usr/bin/env ruby

require 'rubyXL'
require 'pg'

#require_relative 'bdd.rb'
#include Bdd

def connexion_bdd 
    begin
        conn = PG.connect(dbname: 'due', user: 'due', password: 'postgres', host: 'localhost', port: '5432')
        puts "connexion à la base de donnée réussi"
        return conn
    rescue PG::Error => e
        puts "Erreur lors de la connexion à la base de données : #{e.message}"
        exit
    end
end

#insertion dans la bdd
def insert_data(conn, table_name, data) 
    columns = data.first.keys.join(",")
    values = data.map { |row| "(#{row.values.map { |value| "'#{value}'" }.join(",")})" }.join(",")
    conn.exec("INSERT INTO #{table_name} (#{columns}) VALUES #{values}")
end

#selectionne le fichier
monFichier = 'Orders.xlsx'

#ovrir le fichier
workbook = RubyXL::Parser.parse(monFichier)

#déclaration de chaque feuille du fichier
f1 = workbook[0]
f2 = workbook[1]
f3 = workbook[2]

#déclaration d'une liste pour pouvoir plus tard stocker chaque donnée de chaque feuille
orders1 = []
orders2 = []
orders3 = []

#parcours les lignes du fichier
f1.each_with_index do |row, index|
  next if index.zero? #pour ne pas prendre en compte l'en-tête des colonnes

  #prendre les données
  packages = row[0].value
  items = row[1].value
  labels = row[2].value
  values = row[3].value

  #stockage des données dans un hash
  order1 = {
    packages: packages,
    items: items,
    labels: labels,
    values: values
  }

  #ajout à a liste des commandes
  orders1 << order1
end

#affichage dans la console
puts "Voici les données contenus dans Order 1."
orders1.each do |order1|
    puts "Package: #{order1[:packages]}"
    puts "Item: #{order1[:items]}"
    puts "Label: #{order1[:labels]}"
    puts "Value: #{order1[:values]}"
    puts "-" * 20
end

#connexion à la bdd
conn = connexion_bdd #On pourrait ici utiliser : Bdd.connexion_bdd pour ne pas à avoir à écrire tout le code écrit un peu plus haut

#insertion des données de la feuille 1 dans la bdd
insert_data(conn, 'orders', orders1) #On pourrait ici utiliser : Bdd.insert_data(conn, 'orders', orders1) pour ne pas à avoir à écrire tout le code un peu plus haut également.

#fermeture de la connexion à la bdd
conn.close

f2.each_with_index do |row, index|
    next if index.zero? 
  
    packages = row[0].value
    items = row[1].value
    labels = row[2].value
    values = row[3].value
  
    order2 = {
      packages: packages,
      items: items,
      labels: labels,
      values: values
    }
  
    orders2 << order2
end

puts "-" * 20
puts "-" * 20
puts "-" * 20
puts "Voici les données contenus dans Order 2."
orders2.each do |order2|
  puts "Package: #{order2[:packages]}"
  puts "Item: #{order2[:items]}"
  puts "Label: #{order2[:labels]}"
  puts "Value: #{order2[:values]}"
  puts "-" * 20
end

conn = connexion_bdd
insert_data(conn, 'orders', orders2)
conn.close

f3.each_with_index do |row, index|
    next if index.zero? 

    packages = row[0].value
    items = row[1].value
    labels = row[2].value
    values = row[3].value
  
    order3 = {
      packages: packages,
      items: items,
      labels: labels,
      values: values
    }
  
    orders3 << order3
end
puts "-" * 20
puts "-" * 20
puts "-" * 20
puts "Voici les données contenus dans Order 3."
orders3.each do |order3|
  puts "Package: #{order3[:packages]}"
  puts "Item: #{order3[:items]}"
  puts "Label: #{order3[:labels]}"
  puts "Value: #{order3[:values]}"
  puts "-" * 20
end

conn = connexion_bdd
insert_data(conn, 'orders', orders3)
conn.close