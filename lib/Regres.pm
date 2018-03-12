package Regres;
use Mojo::Base 'Mojolicious';

sub startup {
  my $self = shift;

  $self->plugin('PODRenderer');

  $self->hook(
    before_dispatch => sub {
      my $c = shift;
      $c->res->headers->header('Access-Control-Allow-Origin' => '*');
    }
  );
  # Router
  my $r = $self->routes;

  # landing
  $r->get('/')->to('home#landing');

  #users
  $r->post('/register')->to('users#RegisterUser');
  $r->post('/login')->to('users#LoginUser');
  $r->post('/users')->to('users#AddUsers');

  #get list of users
  $r->get('/users')->to('users#GetUsers');

  #get list of jobs
  $r->get('/unknown')->to('jobs#GetJobs');
  $r->put('/jobs')->to('jobs#UpdateJobs');

  #update jobs of user
  $r->put('/users/:id')->to(controller => 'users', action => 'UpdateJob');

}

1;
