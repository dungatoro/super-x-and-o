subset Player where * (elem) <X O>;

class Tile {
    has Player $.winner;
    method is-won { $!winner.defined }
    method Str { $!winner.defined??$!winner!!'_' }
}

class Board {
    # these could also be boards
    has @!tiles;
    method BUILD (UInt :$order) { 
        given $order {
            when 1 -> { @!tiles = [Tile.new xx 9]; }
            default   { @!tiles = [Board.new(order=>$order-1) xx 9]; }
        }
    }

    subset WonRow where { 
        my $w = $_.map({$^a.winner}).unique;
        $w.elems ~~ 1 && $w[0].defined
    }
    method is-won {
        #    HORIZONTAL               VERTICAL                 DIAGONAL
        for (0,1,2),(3,4,5),(6,7,8), (0,3,6),(1,4,7),(2,5,8), (0,4,8),(2,4,6) {
            return True if @!tiles[$_] ~~ WonRow
        }
        False
    }
    method AT-POS ($idx) { @!tiles[$idx] }
    method ASSIGN-POS ($idx, Player $p) {
        @!tiles[$idx] = Tile.new(winner=>$p) unless @!tiles[$idx].is-won;
    }
    method Str { print $_ for @!tiles };
}

my $board = Board.new(order=>2);    
print $board;

