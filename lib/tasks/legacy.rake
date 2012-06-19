namespace :legacy do
  desc "Import the legacy data."
  namespace :import do
    task :user => :environment do
      Legacy::Importer.run("User")
    end

    task :address => :environment do
      Legacy::Importer.run("Address")
    end

    task :closet => :environment do
      Legacy::Importer.run("Closet")
    end

    task :segment => :environment do
      Legacy::Importer.run("Segment")
    end

    task :category => :environment do
      Legacy::Importer.run("Category")
    end

    task :brand => :environment do
      Legacy::Importer.run("Brand")
    end

    %W[SizeGroup CategorizationSizeGroup Size Item Photo Favorite Relationship Cart Order LineItem Conversation Message Activity FacebookAuthentication].each do |kls|
      task kls.downcase.underscore => :environment do
        Legacy::Importer.run(kls)
      end
    end

#     task :sizes => :environment do
#       %W[SizeGroup CategorizationSizeGroup Size].each do |thing|
#         Legacy::Importer.run(thing)
#       end
#     end
  end
end
