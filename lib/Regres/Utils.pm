package Regres::Utils;

use strict;
use warnings;

use Cwd;

use Exporter 'import';
our @EXPORT_OK = ('app_dir'); 

sub app_dir {
    return getcwd;
}

1;
