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
    @intercluster_distances = intercluster_distances clusters
    @intracluster_distances = intracluster_distances clusters
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
      ==> Number of items:    #{@num_items}
      ==> clustered:          #{accumulate_of clusters}
      ==> noise:              #{accumulate_of noise}
      ==> clustered : noise:  #{percent_of clusters}:#{percent_of noise}
      ==>
      ==> Number of clusters:     #{clusters.length}
      ==> Intercluster distances: #{@intercluster_distances}
      ==> Intracluster distances: #{@intracluster_distances}
      ==>
      ==> Avg cluster size:          #{average_of clusters}
      ==> Avg intercluster distance: #{(@intercluster_distances.reduce(:+)/@intercluster_distances.length).round(2)}
      ==> Avg intracluster distance: #{(@intracluster_distances.reduce(:+)/@intracluster_distances.length).round(2)}
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

  def intercluster_distances clusters
    # Return if only one cluster exists
    case clusters.length
    when 1
      return [0.0]
    when 2
      return [distance(centroid(clusters[0]), centroid(clusters[1]))]
    else
      centroids = clusters.map {|c| centroid(c)}
      distances = []
      centroids.each_index do |i|
        centroids.each_index do |j|
          next if i == j
          distances << distance(centroids[i], centroids[j])
        end
      end
      distances
    end
  end

  def intracluster_distances clusters
    distances = []
    clusters.each do |cluster|
      distances << intra_distance(cluster)
    end
    distances
  end

  def intra_distance cluster
    total = 0.0
    sum   = 0
    cluster.each_index do |i|
      cluster.each_index do |j|
        sum += 1
        total += distance cluster[i], cluster[j]
      end
    end
    total / sum
  end

  def centroid cluster
    total = cluster.inject([0.0, 0.0]) do |sum, item|
      [sum[0] + item.x, sum[1] + item.y]
    end
    [total[0]/cluster.length, total[1]/cluster.length]
  end

  def distance a, b
    if a.respond_to?(:x)
      Math.sqrt(((a.x - b.x) ** 2.0) + ((a.y - b.y) ** 2.0))
    else
      Math.sqrt(((a[0] - b[0]) ** 2.0) + ((a[1] - b[1]) ** 2.0))
    end
  end

end
