xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title SITE_TITLE
    xml.description SITE_TITLE
    xml.link request.url.chomp request.path_info
  end
  
  @posts.each do |post|
    xml.item do
      xml.title h post.content
      xml.link "#{request.url.chomp request.path_info}/#{post.id}"
      xml.quid "#{request.url.chomp request.path_info}/#{post.id}"
      xml.pubDate Time.parse(post.created_at.to_s).rfc822
      xml.description h post.content
    end
  end
end
