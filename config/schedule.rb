# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
set :output, "/log/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
every 1.minute do
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

every 1.day do
  Video.where('published_at <= ?', 1.week.ago).destroy_all
end
