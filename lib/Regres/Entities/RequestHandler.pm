package Regres::Entities::RequestHandler;

use strict;
use warnings;

use JSON qw/decode_json encode_json/;
use Config::JSON;
use Moose;
use MooseX::Singleton;
use LWP::UserAgent;
use HTTP::Request;

use Regres::Utils qw/ app_dir /;
use Regres::Entities::Response;

has 'userAgent' => (
    is => 'ro',
    isa => 'LWP::UserAgent',
    builder => '_userAgent'
);

has 'serverEndpoint' => (
    is => 'ro',
    isa => 'Str',
    builder => '_serverEndpoint'
);

sub _userAgent {
    my $ua = LWP::UserAgent->new;
    $ua->agent('Mozilla/5.0');

    return $ua;
}

sub _serverEndpoint {
    return Config::JSON->new( sprintf("%s/share/config.json", app_dir()))->config()->{endPoint};   
}

#sends a request with a given method to a given url
sub SendNoContentRequest {
    my ($self, $path, $method) = @_;

    my $req = HTTP::Request->new($method => sprintf('%s/%s', $self->serverEndpoint(), $path));
    $req->header('content-type' => 'application/json');
    my $resp = $self->userAgent()->request($req);

    return Regres::Entities::Response->new({
                                        statusCode    => $resp->code,
                                        errorOccurred => $resp->is_error,
                                        body          => $resp->decoded_content
                                        });

}

#sends a request with a given method to a given url with a given body
sub SendContentRequest {
    my ($self, $path, $method, $body) = @_;

    my $req = HTTP::Request->new($method => sprintf('%s/%s', $self->serverEndpoint(), $path));
    $req->header('content-type' => 'application/json');
    $req->content($body);

    my $resp = $self->userAgent()->request($req);
    return Regres::Entities::Response->new({
                                        statusCode    => $resp->code,
                                        errorOccurred => $resp->is_error,
                                        body          => $resp->decoded_content
                                        });
}

#sends GET requests to a given url that return pages of a list
#parses all pages and returns all the data
sub SendGetRequestListResult {
    my ($self, $path) = @_;
    
    my $req = HTTP::Request->new(GET => sprintf('%s/%s', $self->serverEndpoint(), $path));
    $req->header('content-type' => 'application/json');    
    my $resp = $self->userAgent()->request($req);

    if ($resp->is_success) {
        my $respBody = decode_json $resp->decoded_content;
        my @propsList = @{$respBody->{data}};

        #check whether there are other pages
        if($respBody->{total_pages} > 1) {
            my $pageCount = 2;

            #go through each page
            while($pageCount <= $respBody->{total_pages}) {
                my $pageResp = $self->SendNoContentRequest(sprintf('%s?page=%s', $path, $pageCount), 'GET');

                #return an error message if something has occured                
                if($pageResp->errorOccurred) {
                    return Regres::Entities::Response->new({
                                                            statusCode    => $pageResp->code,
                                                            errorOccurred => $pageResp->is_error,
                                                            body          => $pageResp->decoded_content
                                                            }); 
                } else {
                    #append data to totals list
                    my $pageRespBody = decode_json $pageResp->body;
                    push @propsList, @{$pageRespBody->{data}};
                }

                $pageCount++;
            }       
        }


        return Regres::Entities::Response->new({
                                                    statusCode    => $resp->code,
                                                    body          => encode_json \@propsList
                                                    });
    } else {
        return Regres::Entities::Response->new({
                                                statusCode    => $resp->code,
                                                errorOccurred => $resp->is_error,
                                                body          => $resp->decoded_content
                                                });    
    }
}

 __PACKAGE__->meta->make_immutable;

1;