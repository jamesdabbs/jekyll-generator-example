module Jekyll
  class EventPage < Page
    def initialize site, d
      @site = site
      @base = site.source
      @name = "event-#{d[:name]}.html"
      @content = ''

      self.process(@name)

      # This should point to your base layout for event pages
      self.read_yaml(File.join(@base, '_layouts'), 'event.html')
      # ^- that template should be able to interpolate {{ page.stuff }} if you do this -v
      self.data['permalink']   = @name
      self.data['headline']    = d[:name]
      self.data['description'] = d[:content]
    end
  end

  class EventPageGenerator < Generator
    def generate site
      event_file = site.config['events'] || File.join(site.source, '_events.yml')
      events = YAML.load_file event_file
      events.each do |event_data|
        site.pages << EventPage.new(site, event_data)
      end
    end
  end
end
