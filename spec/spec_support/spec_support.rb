module SpecSupport
  def steal_logger
    # will let you inspect the logged data for current spec
    # use:
    #   steal_logger
    #   post(....)
    #   expect(app.logger.log).not_to include "secret_accountid_12345"
    #
    # will catch any logging of credentials. E.g.:
    #   logger.debug params.to_s
    #   logger.info params.to_s
    #   logger.warn params.to_s
    #   logger.fatal params.to_s
    #   logger.add 1, params.to_s

    class << app.logger
      def add(severity, message = nil, progname = nil)
        @log="" if (defined?(@log).!)
        @log+= message.to_s
        @log+= progname.to_s
      end

      def log
        @log.to_s
      end
    end
    allow_any_instance_of(app).to receive(:logger).and_return app.logger
    app.logger
  end
end
