require 'csv'
require 'bundler'
Bundler.require



class Gossip
    attr_accessor :author, :content

    def initialize(author_to_save, content_to_save)
        @author = author_to_save
        @content = content_to_save
      end

    def save
        file = CSV.open("db/gossip.csv", "ab") do |csv|
        csv << [@author,@content]
      end

      def self.edit(author,content,index)
        all_gossips = CSV.read('db/gossip.csv')
        all_gossips.delete_at(index.to_i-1)
        all_gossips.insert(index.to_i-1,[author,content])
    
        file = CSV.open('db/gossip.csv','w')
        all_gossips.each do |line|
          file.add_row(line)
        end
        file.close
      end

      def self.all
        all_gossips = []
        CSV.read("./db/gossip.csv").each do |csv_line|
          all_gossips << Gossip.new(csv_line[0], csv_line[1])
        end
        return all_gossips
      end

      def self.destroy(index)
        all_gossips = CSV.read('db/gossip.csv')
        all_gossips.delete_at(index)
    
        File.open('db/gossip.csv', 'w') do |csv|
          all_gossips.each do |line|
            csv << line.join(',')
            csv << ("\n")
          end

          def Gossip.all
            redirect_to show_path
          end
    end
end
end
end

