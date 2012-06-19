namespace :photos do
  namespace :to do
    task :tmp => :environment do
      puts "Moving photos to temporary directory..."
      return
      ::Photo.order("item.legacy_id ASC").find_in_batches(:batch_size => 50) do |batch|
        batch.each do |photo|
          src = "#{Rails.root}/public/#{photo.image.legacy_dir}"
          tmp = "#{Rails.root}/public/#{photo.image.tmp_dir}"
          dest = "#{Rails.root}/public/#{photo.image.store_dir}"
          puts src
          if Dir.exists?(src)
            puts [src, tmp].join(" => ")
            # FileUtils.mv(src, tmp, verbose: true, force: true)
            # binding.pry
            # FileUtils.remove_dir(src) if Dir.exists?(tmp) and Dir.exists?(src)
          end
        end
      end
    end
    task :dest => :environment do
      puts "Moving photos to destination directory..."
      return
      ::Photo.order("item.legacy_id ASC").find_in_batches(:batch_size => 50) do |batch|
        batch.each do |photo|
          src = "#{Rails.root}/public/#{photo.image.legacy_dir}"
          tmp = "#{Rails.root}/public/#{photo.image.tmp_dir}"
          dest = "#{Rails.root}/public/#{photo.image.store_dir}"
          if Dir.exists?(tmp)
            FileUtils.mv(tmp, dest, verbose: true)
            FileUtils.remove_dir(tmp) if Dir.exists?(dest) and Dir.exists?(tmp)
          end
        end
      end
    end
  end
end
