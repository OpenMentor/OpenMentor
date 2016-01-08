# Open Mentor

Welcome! This application serves to connect individuals seeking mentorship with individuals wishing to
help others learn and grow. It's no secret that many grow and advance with the help of one on one instruction
in the form of mentorship throughout life. Yet, the world is not fair, and not all of us are lucky enough
to grow up surrounded by those experienced in various skills or abilities.

Open Mentors recognizes that technology can help offset the inequality of opportunity by allowing individuals of various backgrounds
a place to connect and engage. Learn together today and grow together tomorrow.

We invite anyone interested in participating in this community to always consider themselves a mentor and a mentee.
As the great Phil Collins once said "In learning you will teach, and in teaching you will learn."

### Contributing!

A more formal contributing document is in the works, but for now, if you wish to participate in the development of Open Mentor
we kindly ask you to create an issue in this repository expressing your desire. Someone in the Open Mentor organization will
help you get started and identify a project or feature to work on as we prepare for the initial release. Please see the setup
instructions below for configuring your development environment.

Please also note that we subscribe to [v1.3 of the contributor covenant](http://contributor-covenant.org/). We welcome all
who wish to contribute to this project. We ask that every contributor behave in a respectful and humble way to all others,
regardless of category or identity. We take this very seriously and no exceptions for improper or disrespectful conduct
will be tolerated. Prior to contributing you are kindly asked to read our
[contributor covenant](https://github.com/OpenMentor/OpenMentor/blob/3e340701d0fd9fd9fb28c70e9612244f9179b164/CODE_OF_CONDUCT.md).

### Setup

This project assumes you have PostGreSQL v9.4.5 installed along with [Mailcatcher](http://mailcatcher.me/).
We also use Ruby v2.2.4-p173.

An initialize file exists to seed your development database:

```bash
$ bundle
$ bundle exec rake db:create db:migrate
$ bundle exec rake initialize:all
```

Once your development database is setup, you should be able to start your rails server and signup!

```bash
$ bundle exec rails s
```

You'll have to make sure you have Mailcatcher running (it runs as a daemon in the background) before
signing up. Assuming Mailcatcher is running, when you signup a confirmation email will be captured by
Mailcatcher and viewable by visiting [http://localhost:1080/](http://localhost:1080/) in your browser.

There you should see the confirmation email with the confirm link. Following that link should allow you
to complete your signup.

### Tests

This project uses `RSpec` for testing. To run tests:

```bash
$ bundle
$ bundle rake db:migrate db:test:prepare
$ bundle exec rspec
```

Any new feature of contribution added to this project is expected to have tests verifying
the proper behavior.

### Contributing Steps

1. Fork this repository
2. Clone to your local development machine
3. Add your feature / specs
4. Push to your fork
5. Open a Pull Request to the master branch of this repository

### License

This project carries the [GNUv2](https://github.com/OpenMentor/OpenMentor/blob/756e56a829630ef3d810cc953629fd977f8a1399/LICENSE.txt) license.

Copyright 2015 ~ 2016 Open Mentor
