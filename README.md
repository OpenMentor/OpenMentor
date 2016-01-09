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

We welcome any and all contributions! From documentation to feature work, fixing typos or enhancing existing functionality, all
contributions are valuable.

Please see this [list of issues](https://github.com/OpenMentor/OpenMentor/issues) for a complete list of possible contributions you can make.

Please also note that we subscribe to [v1.3 of the contributor covenant](http://contributor-covenant.org/). We welcome all
who wish to contribute to this project. We only ask that every contributor behave in a respectful and humble way to all others,
regardless of category or identity. We take this very seriously and no exceptions for improper or disrespectful conduct
will be tolerated. Prior to contributing you are kindly asked to read our
[contributor covenant](https://github.com/OpenMentor/OpenMentor/blob/3e340701d0fd9fd9fb28c70e9612244f9179b164/CODE_OF_CONDUCT.md).

To get started, create a fork of this repository and follow the setup instructions. If you run into issues installing any of the
dependencies or you get stuck, feel free to open an issue, and someone will help unblock you.

All proposed feature work should be adequately covered with tests. Submissions that do not provide adequate test coverage will be kindly
asked to add test coverage before they will be merged. If you are new to testing but want to make contributions, please also feel free
to open an issue to request pairing or help. We are happy to help those that are willing to learn while we work towards v1 of this application.

### Contributing Steps

1. Fork this repository
2. Clone to your local development machine
3. Add your feature / specs
4. Push to your fork
5. Open a Pull Request to the master branch of this repository

### Setup

1. Install dependencies

- Ruby v2.2.4-p173
- PostGreSQL v9.4.5 (on OSx you can install via [homebrew](http://brew.sh/))
- [Mailcatcher](http://mailcatcher.me/)

2. Setup your development database:

```bash
$ bundle
$ bundle exec rake db:create db:migrate
$ bundle exec rake initialize:all
```

3. Start Mailcatcher:

Mailcatcher runs as a daemon process, but it needs to be started:

`$ mailcatcher`

If you installed the Mailcatcher gem correctly, the `mailcatcher` binary should already
be installed and included in your Ruby path by default. Depending on the Ruby version manager
you use problems can arise. If you are stuck, please feel free to open an issue and someone will
help you debug the problem.

3. Start the app:

```bash
$ bundle exec rails s
```

4. Verify your Rails server is running:

Visit 'localhost:3000' in your browser of choice. Assuming everything is setup correctly so far, you should
see the sign in form.

If you are experiencing an issue that you cannot debug, please open an issue and include the error message
and stack trace.

5. Verify Mailcatcher is running:

You'll have to make sure you have Mailcatcher running (it runs as a daemon in the background) before
signing up (`$ mailcatcher`). Assuming Mailcatcher is running, when you signup a confirmation email will be captured by
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

### License

This project carries the [GNUv2](https://github.com/OpenMentor/OpenMentor/blob/756e56a829630ef3d810cc953629fd977f8a1399/LICENSE.txt) license.

Copyright 2015 ~ 2016 Open Mentor
