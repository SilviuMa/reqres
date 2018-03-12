package Regres::Controller::Jobs;

use Mojo::Base 'Mojolicious::Controller';

use Moose;
use JSON qw/decode_json encode_json/;

use Regres::Entities::RequestHandler;

sub GetJobs {
    my $self = shift;

    return $self->render(json => Regres::Entities::RequestHandler->instance->SendGetRequestListResult('unknown')->TO_JSON());
}

sub UpdateJobs {
    my $self = shift;

    #get users list
    my $users = decode_json(Regres::Entities::RequestHandler->instance->SendGetRequestListResult('users')->body());
    
    my $newJob = decode_json($self->req->body)->{job};

    my @responses = ();

    #update each user's job
    foreach my $user ( @$users ) {
        $user->{job} = $newJob;
        push @responses, Regres::Entities::RequestHandler->instance->SendContentRequest(sprintf('users/%s', 
                                                                                                $user->{id}), 
                                                                                        $self->req->method, 
                                                                                        encode_json $user);
    }

    return $self->render(json => \@responses);
}


1;
