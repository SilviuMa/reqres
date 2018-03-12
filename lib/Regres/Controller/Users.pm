package Regres::Controller::Users;

use Mojo::Base 'Mojolicious::Controller';

use Moose;
use JSON qw/decode_json encode_json/;

use Regres::Entities::RequestHandler;

sub RegisterUser {
    my $self = shift;

    return $self->render(json => Regres::Entities::RequestHandler->instance->SendContentRequest('register', 
                                                                                                 $self->req->method,               
                                                                                                 $self->req->body)->TO_JSON());
}

sub LoginUser {
    my $self = shift;

    return $self->render(json => Regres::Entities::RequestHandler->instance->SendContentRequest('login', 
                                                                                                 $self->req->method,               
                                                                                                 $self->req->body)->TO_JSON());
}

sub AddUsers {
    my $self = shift;

    my $userList = decode_json($self->req->body);

    my @responses = ();
    #iterate through each user and insert them
    foreach my $user ( @$userList ) {
        push @responses, Regres::Entities::RequestHandler->instance->SendContentRequest('users', 
                                                                                        $self->req->method,               
                                                                                        encode_json $user)->body();        
    }

    return $self->render(json => \@responses);
}

sub GetUsers {
    my $self = shift;

    return $self->render(json => Regres::Entities::RequestHandler->instance->SendGetRequestListResult('users', $self->req->method)->TO_JSON());
}

1;
