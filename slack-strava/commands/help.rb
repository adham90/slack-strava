module SlackStrava
  module Commands
    class Help < SlackRubyBot::Commands::Base
      HELP = <<~EOS.freeze
        ```
        Slava: Strava and MapMyRun integration with Slack.

        DM
        -------
        connect             - connect your Strava or MapMyRun account

        Settings
        --------
        set units mi/km     - use miles or kilometers

        General
        -------
        help                - get this helpful message
        subscription        - show subscription info
        ```
EOS
      def self.call(client, data, _match)
        client.say(channel: data.channel, text: [
          HELP,
          SlackStrava::INFO,
          client.owner.reload.subscribed? ? nil : client.owner.subscribe_text
        ].compact.join("\n"))
        client.say(channel: data.channel, gif: 'help')
        logger.info "HELP: #{client.owner}, user=#{data.user}"
      end
    end
  end
end
