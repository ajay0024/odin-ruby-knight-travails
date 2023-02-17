def legal(x, y)
  x > 0 && x <= 7 && y >= 0 && y <= 7
end

def nodeToNumber(arr)
  arr[0] * 8 + arr[1]
end

def numberToNode(number)
  [number/8, number%8]
end

def give_possible_moves(x, y)
  possible_changes = [[2, 1], [1, 2], [2, -1], [-1, 2], [-2, 1], [1, -2], [-1, -2], [-2, -1]]
  possible_moves = []
  possible_changes.each { |n| possible_moves << nodeToNumber([x + n[0], y + n[1]]) if legal(x + n[0], y + n[1]) }
  possible_moves
end

def make_board_edges
  edges = []
  for x in (0..7)
    for y in (0..7)
      edges << give_possible_moves(x, y)
    end
  end
  edges
end

def knight_moves(src, dest)
  src = nodeToNumber(src)
  dest = nodeToNumber(dest)
  findShortestPath(src, dest)
end

def BFS(src, dest)
  edges = make_board_edges
  visited = Array.new(64, false)
  queue = []
  dist = Array.new(64, Float::INFINITY)
  pred = Array.new(64, -1)
  visited[src] = true
  dist[src] = 0
  queue.unshift(src)
  until queue.empty?
    u = queue.shift
    for x in edges[u]
      unless visited[x]
        visited[x] = true
        dist[x] = dist[u] + 1
        pred[x] = u
        queue.unshift(x)
        if (x == dest)
          return pred
        end
      end
    end
  end
  return nil
end

def findShortestPath(src, dest)
  pred = BFS(src, dest)
  path = [dest]
  unless pred.nil?
    crawl = dest
    while (pred[crawl] != -1)
      path.unshift(pred[crawl])
      crawl = pred[crawl]
    end
    puts "You made it in #{path.length}! Here is your path:"
    puts path.map { |x| numberToNode(x).to_s}
  else
    puts "Couln't find shortest path"
  end
end

knight_moves([0, 0], [2, 0])
