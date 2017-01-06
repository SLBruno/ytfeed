desc "puxar os novos videos 2x ao dia"
task :update_feed => :enviroment do
  Video.YTCHID.each do |channelid|
    channel = Yt::Channel.new id:channelid
    videosid = channel.videos.take(4).map(&:id)
    videosid.each do |vid|
      video = Yt::Video.new id:vid
      if Video.exists?(url: "http://youtube.com/watch?v=#{vid}")
      else
        Video.create(title:video.title,
                    url:"http://youtube.com/watch?v=#{vid}",
                    description: video.description,
                    published_at: video.published_at.strftime('%Y-%m-%d %H:%M:%S'),
                    thumbnail_url: "http://img.youtube.com/vi/#{vid}/mqdefault.jpg",
                    channel_title: video.channel_title,
                    duration: video.duration)
        end
      end
  end
end

desc "apagar os vídeos que tem mais de 14 dias"

task :delete_old_videos => :enviroment do
  Video.where('published_at <= ?', 2.weeks.ago).destroy_all
end
