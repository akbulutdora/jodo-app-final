{application,jodoapp,
             [{compile_env,[{jodoapp,['Elixir.JodoappWeb.Gettext'],error}]},
              {applications,[kernel,stdlib,elixir,logger,runtime_tools,
                             bcrypt_elixir,phoenix,phoenix_ecto,ecto_sql,
                             postgrex,phoenix_html,phoenix_live_reload,
                             phoenix_live_view,phoenix_live_dashboard,esbuild,
                             swoosh,telemetry_metrics,telemetry_poller,
                             gettext,jason,plug_cowboy]},
              {description,"jodoapp"},
              {modules,['Elixir.Inspect.Jodoapp.Accounts.User',
                        'Elixir.Jason.Encoder.Jodoapp.Accounts.User',
                        'Elixir.Jason.Encoder.Jodoapp.Blocks.Block',
                        'Elixir.Jodoapp','Elixir.Jodoapp.Accounts',
                        'Elixir.Jodoapp.Accounts.User',
                        'Elixir.Jodoapp.Accounts.UserNotifier',
                        'Elixir.Jodoapp.Accounts.UserToken',
                        'Elixir.Jodoapp.Application','Elixir.Jodoapp.Blocks',
                        'Elixir.Jodoapp.Blocks.Block','Elixir.Jodoapp.Mailer',
                        'Elixir.Jodoapp.Release','Elixir.Jodoapp.Repo',
                        'Elixir.JodoappWeb',
                        'Elixir.JodoappWeb.API.V1.BlockController',
                        'Elixir.JodoappWeb.API.V1.RegistrationController',
                        'Elixir.JodoappWeb.API.V1.SessionController',
                        'Elixir.JodoappWeb.BlockLive.FormComponent',
                        'Elixir.JodoappWeb.BlockLive.Index',
                        'Elixir.JodoappWeb.BlockLive.Show',
                        'Elixir.JodoappWeb.ChangesetView',
                        'Elixir.JodoappWeb.Endpoint',
                        'Elixir.JodoappWeb.ErrorHelpers',
                        'Elixir.JodoappWeb.ErrorView',
                        'Elixir.JodoappWeb.FallbackController',
                        'Elixir.JodoappWeb.Gettext',
                        'Elixir.JodoappWeb.LayoutView',
                        'Elixir.JodoappWeb.LiveHelpers',
                        'Elixir.JodoappWeb.PageController',
                        'Elixir.JodoappWeb.PageView',
                        'Elixir.JodoappWeb.Router',
                        'Elixir.JodoappWeb.Router.Helpers',
                        'Elixir.JodoappWeb.Telemetry',
                        'Elixir.JodoappWeb.UserAuth',
                        'Elixir.JodoappWeb.UserConfirmationController',
                        'Elixir.JodoappWeb.UserConfirmationView',
                        'Elixir.JodoappWeb.UserRegistrationController',
                        'Elixir.JodoappWeb.UserRegistrationView',
                        'Elixir.JodoappWeb.UserResetPasswordController',
                        'Elixir.JodoappWeb.UserResetPasswordView',
                        'Elixir.JodoappWeb.UserSessionController',
                        'Elixir.JodoappWeb.UserSessionView',
                        'Elixir.JodoappWeb.UserSettingsController',
                        'Elixir.JodoappWeb.UserSettingsView']},
              {registered,[]},
              {vsn,"0.1.0"},
              {mod,{'Elixir.Jodoapp.Application',[]}}]}.