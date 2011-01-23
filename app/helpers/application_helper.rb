require 'uri'

module ApplicationHelper
  def title
    base_title = "Ruby on Rails Tutorial Sample App"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end

  def logo
    image_tag "rails.png", :alt => "Sample App", :class => "round"
  end

  def rails_logo
    image_tag "rails.png"
  end

  def markdown(txt)
    BlueCloth.new(h(txt)).to_html
  end

  def has_attachment?(pic)
    not pic.url.end_with? "missing.png"
  end

  def city_ids
    City.all.collect { |city| [city.name, city.id] }
  end

  def expired_title(obj)
    if obj.expired?
      obj.title + '(已过期)'
    else
      obj.title
    end
  end

  def admin_and_creator_of?(user)
    current_user.admin? and current_user?(user)
  end

  def tuan_has_logo?(url)
    host = URI.parse(url).host
    unless host.nil?
      logos = {
        :meituan => "http://s0.meituan.com/css/i/logo.gif", # 美团
        :groupon => "http://www.17tuanbao.com/images/logo3.png", # 团宝
        :mituan => "http://static.mituan.com/images/logo.gif", # 米团
        :cooltuan => "http://www.cooltuan.com/cachedstatic/www_cooltuan_com/pic/logo.jpg", # 酷团
        :manzuo => "http://img0.manzuo.com/html/images/manzuologo/logo.jpg", # 满座
        :runtuan => "http://www.runtuan.com/Public/upload/public/201008/4c56393e4c3e9.jpg", # 赶团
      }
      logos[host.split('.')[-2].to_sym]
    end
  end
end

