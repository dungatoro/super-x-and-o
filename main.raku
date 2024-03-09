class Tile {
    has $.winner = Nil; 
}

subset WonRow where *.map($_.winner).unique ~~ Nil && *.elems ~~ 1;
class Board {
    # these could also be boards
    has @.tiles = Tile.new xx 9;

    method is-won {
        #    HORIZONTAL               VERTICAL                 DIAGONAL
        for (0,1,2),(3,4,5),(6,7,8), (0,3,6),(1,4,7),(2,5,8), (0,4,8),(2,4,6) {
            True if @!tiles[$_] ~~ WonRow;
        }
    }
}

my @m = [1, 2, 3, 4, 5, 6, 7, 8, 9];
say @m[(4, 5, 6)];
