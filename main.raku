class Tile {
    has $.winner = Nil; 
}

subset WonRow where *.map($_.winner).unique ~~ Nil and *.elems == 1;
class Board {
    # these could also be boards
    has $.tiles = [Tile.new xx 3] xx 3;

    method is-won {
        {True if $_ ~~ WonRow} for $!tiles;
    }
}
