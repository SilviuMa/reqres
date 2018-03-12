package Regres::Entities::Response;

use strict;
use warnings;

use Moose;

has 'statusCode' => (
    is => 'ro',
    isa => 'Num'
);

has 'errorOccurred' => (
    is => 'rw',
    isa => 'Bool',
    default => 0
);

has 'body' => (
    is => 'ro',
    isa => 'Str'
);

sub TO_JSON { 
    my $data = { %{ shift() } }; 
    $data =~ s/\\"/"/;
    return $data;
}

 __PACKAGE__->meta->make_immutable;