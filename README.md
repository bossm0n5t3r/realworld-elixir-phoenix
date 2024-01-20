# RealworldElixirPhoenix

To start your Phoenix server:

- Run `mix setup` to install and setup dependencies
- Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

- Official website: https://www.phoenixframework.org/
- Guides: https://hexdocs.pm/phoenix/overview.html
- Docs: https://hexdocs.pm/phoenix
- Forum: https://elixirforum.com/c/phoenix-forum
- Source: https://github.com/phoenixframework/phoenix

## How to create

```shell
~/gitFolders
❯ mix phx.new realworld-elixir-phoenix --no-assets --no-html --binary-id --app realworld_elixir_phoenix
* creating realworld-elixir-phoenix/lib/realworld_elixir_phoenix/application.ex
* creating realworld-elixir-phoenix/lib/realworld_elixir_phoenix.ex
* creating realworld-elixir-phoenix/lib/realworld_elixir_phoenix_web/controllers/error_json.ex
* creating realworld-elixir-phoenix/lib/realworld_elixir_phoenix_web/endpoint.ex
* creating realworld-elixir-phoenix/lib/realworld_elixir_phoenix_web/router.ex
* creating realworld-elixir-phoenix/lib/realworld_elixir_phoenix_web/telemetry.ex
* creating realworld-elixir-phoenix/lib/realworld_elixir_phoenix_web.ex
* creating realworld-elixir-phoenix/mix.exs
* creating realworld-elixir-phoenix/README.md
* creating realworld-elixir-phoenix/.formatter.exs
* creating realworld-elixir-phoenix/.gitignore
* creating realworld-elixir-phoenix/test/support/conn_case.ex
* creating realworld-elixir-phoenix/test/test_helper.exs
* creating realworld-elixir-phoenix/test/realworld_elixir_phoenix_web/controllers/error_json_test.exs
* creating realworld-elixir-phoenix/lib/realworld_elixir_phoenix/repo.ex
* creating realworld-elixir-phoenix/priv/repo/migrations/.formatter.exs
* creating realworld-elixir-phoenix/priv/repo/seeds.exs
* creating realworld-elixir-phoenix/test/support/data_case.ex
* creating realworld-elixir-phoenix/lib/realworld_elixir_phoenix/mailer.ex
* creating realworld-elixir-phoenix/lib/realworld_elixir_phoenix_web/gettext.ex
* creating realworld-elixir-phoenix/priv/gettext/en/LC_MESSAGES/errors.po
* creating realworld-elixir-phoenix/priv/gettext/errors.pot
* creating realworld-elixir-phoenix/priv/static/robots.txt
* creating realworld-elixir-phoenix/priv/static/favicon.ico

Fetch and install dependencies? [Yn]
* running mix deps.get
* running mix deps.compile

We are almost there! The following steps are missing:

    $ cd realworld-elixir-phoenix

Then configure your database in config/dev.exs and run:

    $ mix ecto.create

Start your Phoenix app with:

    $ mix phx.server

You can also run your app inside IEx (Interactive Elixir) as:

    $ iex -S mix phx.server


~/gitFolders 33s
❯

```

## References

### RealWorld

- [https://realworld-docs.netlify.app/](https://realworld-docs.netlify.app/)
- [https://github.com/gothinkster/realworld](https://github.com/gothinkster/realworld)
- [https://github.com/tamanugi/realworld-phoenix](https://github.com/tamanugi/realworld-phoenix)

### Auth

- [https://medium.com/wttj-tech/elixirs-best-practices-achieve-secure-authentication-8961f60effc7](https://medium.com/wttj-tech/elixirs-best-practices-achieve-secure-authentication-8961f60effc7)
- [https://levelup.gitconnected.com/a-deep-dive-into-authentication-in-elixir-phoenix-with-phx-gen-auth-9686afecf8bd](https://levelup.gitconnected.com/a-deep-dive-into-authentication-in-elixir-phoenix-with-phx-gen-auth-9686afecf8bd)
