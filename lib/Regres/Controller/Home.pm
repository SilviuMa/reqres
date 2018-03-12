package Regres::Controller::Home;

use Mojo::Base 'Mojolicious::Controller';

sub landing {
    my $self = shift;
    
    $self->render(template => '/regres/landing');
}

1;
