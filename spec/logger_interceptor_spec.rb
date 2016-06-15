describe "spec_support/logger_interceptor" do

  context "steal_logger!" do
    after :each do
      release_logger!
    end

    it "should add instance methods to logger singleton class" do
      expect(app.logger.singleton_methods).not_to include :add
      expect(app.logger.singleton_methods).not_to include :log
      expect(app.logger.instance_variables).not_to include :@log

      steal_logger!

      expect(app.logger.singleton_methods).to include :add
      expect(app.logger.singleton_methods).to include :log
      expect(app.logger.instance_variables).to include :@log

    end

    it "should raise if already called" do
      steal_logger!
      expect { steal_logger! }.to raise_error RuntimeError
    end
  end

  context "release_logger!" do
    it "should remove instance methods from logger singleton class" do
      steal_logger!
      release_logger!

      expect(app.logger.singleton_methods).not_to include :add
      expect(app.logger.singleton_methods).not_to include :log
      expect(app.logger.instance_variables).not_to include :@log
    end

    it "should NOT raise if already called" do
      steal_logger!
      release_logger!

      expect { release_logger! }.not_to raise_error
    end
  end

  context "logging messages" do
    after :each do
      release_logger!
    end

    it "should be intercepted" do
      steal_logger!

      expect(app.logger.log).to eq ""

      app.logger.debug "log debug test message"
      app.logger.info "log info test message"
      app.logger.warn "log warn test message"
      app.logger.fatal "log fatal test message"
      app.logger.add 1, "log add 1 test message"

      expect(app.logger.log).to include "log debug test message"
      expect(app.logger.log).to include "log info test message"
      expect(app.logger.log).to include "log warn test message"
      expect(app.logger.log).to include "log fatal test message"
      expect(app.logger.log).to include "log add 1 test message"
    end

    it "should be intercepted in controllers" do
        steal_logger!

        app.get("/test_with_logging") do
          logger.info "test_with_logging from controller message"
        end

        get("/test_with_logging")

        expect(app.logger.log).to eq "test_with_logging from controller message"
    end
  end
end
