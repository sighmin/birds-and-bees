class Ants::Sims::Analyzer

  attr_accessor :algorithm
  attr_accessor :clusters, :noise
  MINIMUM = 3

  def algorithm= algorithm
    @algorithm = algorithm
    @num_items = 0
  end

  def run
    @clusters = dbscan algorithm.grid.items
    @num_items = algorithm.grid.items.length
  end

  def report
    <<-EOS.gsub(/^ {6}/, "")
      ==> Report
      ==>
      ==> Minimum cluster size: #{MINIMUM}
      ==> All Clusters: #{clusters.map {|c| c.length} + noise.map {|c| c.length}}
      ==> Clusters:     #{clusters.map {|c| c.length}}
      ==> Noise:        #{noise.map {|c| c.length}}
      ==> Noise coords: #{noise.map {|c| [c[0].x,c[0].y]}}
      ==>
      ==> Number of items: #{@num_items}
      ==> clustered:       #{accumulate_of clusters}
      ==> noise:           #{accumulate_of noise}
      ==> % clustered:     #{percent_of clusters}%
      ==> % noise:         #{percent_of noise}%
      ==>
      ==> Number of clusters: #{clusters.length}
      ==> Avg cluster size:   #{average_of clusters}
      ==>
      ==> Intercluster distance:     #{}
      ==> Avg intracluster distance: #{}
    EOS
  end

private

  def percent_of list
    (accumulate_of(list) / @num_items.to_f * 100).round(2)
  end

  def accumulate_of list
    arr = list.map {|i| i.length}
    return 0 if arr.empty?
    arr.reduce(:+)
  end

  def average_of list
    sum = accumulate_of list
    (sum / list.length).round(2)
  end

  def dbscan items
    cluster_list = []
    loop do
      current = next_unvisited items
      break if current.nil?

      cluster = []
      cluster_list << cluster

      rec_add_to_cluster cluster, current
    end
    @noise = cluster_list.select {|c| c.length < MINIMUM}
    cluster_list.reject! {|c| c.length < MINIMUM}
    cluster_list
  end

  def rec_add_to_cluster cluster, current
    #puts algorithm.grid
    #puts "adding #{[current.x, current.y]}"
    #binding.pry
    current.visit
    cluster << current
    neighbors = unvisited_neighbors current

    return if neighbors.empty?

    neighbors.each do |neighbor|
      rec_add_to_cluster cluster, neighbor if neighbor.unvisited?
    end
  end

  def unvisited_neighbors item
    algorithm.grid.neighbors(item).select {|i| i.unvisited? }
  end

  def next_unvisited items
    items.select {|i| i.unvisited? }.first
  end

end
