module StateMachine
  module Bug
    extend ActiveSupport::Concern
    included do
      include AASM
      enum bug_status: {
        initial: 0,
        started: 1,
        completed: 2,
        resolved: 3
      }

      aasm column: :bug_status, enum: true, whiny_transitions: false do
        state :initial, initial: true
        state :started
        state :completed
        state :resolved

        event :set_bug_next_state do
          transitions from: %i[completed resolved], to: :started
          transitions from: :started, to: :completed, guard: :feature?
          transitions from: :started, to: :resolved, guard: :bug?
          transitions from: :initial, to: :started
        end
      end

      def feature?
        bug_type == 'feature'
      end

      def bug?
        bug_type == 'bug'
      end
    end
  end
end
