subset Player where * (elem) <X O>;

class Tile {
    has Player $.winner;
    method is-won { $!winner.defined }
    method Str { $!winner.defined??$!winner!!'_' }
}

subset WonRow where { 
    my $w = $_.map({$^a.winner}).unique;
    $w.elems ~~ 1 && $w[0].defined
}

class Board {
    # these could also be boards
    has @!tiles = [Tile.new xx 9];

    method is-won {
        #    HORIZONTAL               VERTICAL                 DIAGONAL
        for (0,1,2),(3,4,5),(6,7,8), (0,3,6),(1,4,7),(2,5,8), (0,4,8),(2,4,6) {
            return True if @!tiles[$_] ~~ WonRow
        }
        False
    }

    method ASSIGN-POS (UInt $idx, Player $p) {
        @!tiles[$idx] = Tile.new(winner=>$p) unless @!tiles[$idx].is-won;
    }
}
