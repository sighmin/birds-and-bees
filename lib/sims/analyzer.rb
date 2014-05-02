class Ants::Sims::Analyzer

  attr_accessor :grid, :clusters
  MINIMUM = 2
  # Report:
  # a. Number of items
  # b. % of items clustered
  # c. % of noise
  #
  # 1. Number of clusters
  # 2. Average cluster size
  #
  # 3. Intercluster distance
  # 4. Average intracluster distances

  def initialize grid
    @grid = grid
    @clusters = []

    # set A
    @num_items = 0
    @percent_clustered  = 0.0
    @percent_noise      = 0.0
    # set B
    @num_clusters       = 0
    @avg_cluster_size   = 0
    # set C
    @inter_c_distance   = 0.0
    @avg_intra_distance = 0.0
  end

  def analyze
    # run dbscan to populate @clusters
    # calc set A
    @num_items = grid.items.length
    # calc set B
    # calc set C
  end

  def report
    "==> Report\n" \
  + "==> " \
  + "==> Number of items: #{}" \
  + "==> % clustered:     #{}%" \
  + "==> % noise:         #{}%" \
  + "==> " \
  + "==> Number of clusters: #{}" \
  + "==> Avg cluster size:   #{}" \
  + "==> " \
  + "==> Intercluster distance:     #{}" \
  + "==> Avg intracluster distance: #{}" \
  + "\n"
  end

private

  # DBSCAN(D, eps, MinPts)
  #    C = 0
  #    for each unvisited point P in dataset D
  #       mark P as visited
  #       NeighborPts = regionQuery(P, eps)
  #       if sizeof(NeighborPts) < MinPts
  #          mark P as NOISE
  #       else
  #          C = next cluster
  #          expandCluster(P, NeighborPts, C, eps, MinPts)
  def dbscan
    grid.items.each do |item|
      next if item.visited?
      item.visit
      neighbors = region_query item
      if neighors.length < MINIMUM
        item.noise
      else
        @clusters << []
        expand_cluster item, neighbors, @clusters[@clusters.length-1]
      end
    end
  end

  # regionQuery(P, eps)
  #    return all points within P's eps-neighborhood (including P)
  def region_query item
    grid.neighbors item
  end

  # expandCluster(P, NeighborPts, C, eps, MinPts)
  #    add P to cluster C
  #    for each point P' in NeighborPts
  #       if P' is not visited
  #          mark P' as visited
  #          NeighborPts' = regionQuery(P', eps)
  #          if sizeof(NeighborPts') >= MinPts
  #             NeighborPts = NeighborPts joined with NeighborPts'
  #       if P' is not yet member of any cluster
  #          add P' to cluster C
  def expand_cluster item, neighbors, cluster
    cluster << item
    neighbors.each do |neighbor|
      if !neighbor.visited?
        neighbor.visit
        distant_neighbors = region_query neighbor
        if distant_neighbors.length >= MINIMUM
          neighbors += distant_neighbors
        end
      end
      in_a_cluster = false
      @clusters.each do |c|
        in_a_cluster = true if c.include? neighbor
      end
      unless in_a_cluster
        cluster << neighbor
      end
    end
  end

end
