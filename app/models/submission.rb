# Submission class
# Sumbission is the entity the keeps track of a specific trainee's submission
class Submission < ApplicationRecord
  # Associations
  belongs_to :trainee
  # Enums
  enum verdict: [
    :submission_error,
    :cant_be_judged,
    :in_queue,
    :compile_error,
    :restricted_function,
    :runtime_error,
    :output_limit,
    :time_limit,
    :memory_limit,
    :wrong_answer,
    :presentation_error,
    :accepted
  ]
end
