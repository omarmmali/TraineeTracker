require 'open-uri'
require 'nokogiri'
class TraineeTracker
  def update_trainee_submissions
    @trainees = Trainee.all.where(tracking_status: 1)
    loop do
      @trainees.each do |t|
        codeforces_submissions(t)
        uva_submissions(t)
        live_archive_submissions(t)
        spoj_submissions(t)
        timus_submissions(t)
        uri_submissions(t)
      end
    end
  end
  def codeforces_submissions(trainee)
    link = "http://codeforces.com/api/user.status?handle=#{trainee.codeforces_handle}&from=1&count=1"
    response = JSON.parse(HTTP.get(link).body.to_s)
    return unless response['status'] == 'OK'
    response = response['result'][0]
    problem_id = response['problem']['name']
    verdict = codeforces_translate(response['verdict'])
    unless Submission.find_by(
      trainee_id: trainee.id,
      problem_judge: 'codeforces',
      problem_id: problem_id,
      verdict: verdict
    )
      Submission.create(
        trainee_id: trainee.id,
        problem_judge: 'codeforces',
        problem_id: problem_id,
        verdict: verdict
      )
    if verdict == :accepted
      flash[:success] = 'Trainee #{trainee.name} solved problem #{problem_id}'
    end
    end
  end
  def uva_submissions(trainee)
    link = "http://uhunt.onlinejudge.org/api/subs-user-last/#{trainee.uva_handle}/1"
    response = JSON.parse(HTTP.get(link).body.to_s)
    return response['name'].blank?
    response = response['subs'][0]
    problem_id = response[1]
    verdict = uva_translate(response[2])
    unless Submission.find_by(
      trainee_id: trainee.id,
      problem_judge: 'uva',
      problem_id: problem_id,
      verdict: verdict
    )
      Submission.create(
        trainee_id: trainee.id,
        problem_judge: 'uva',
        problem_id: problem_id,
        verdict: verdict
      )
      if verdict == :accepted
        flash[:success] = 'Trainee #{trainee.name} solved problem #{problem_id}'
      end
    end
  end
  def live_archive_submissions(trainee)
    link = "https://icpcarchive.ecs.baylor.edu/uhunt/api/subs-user-last/#{trainee.live_archive_handle}/1"
  response = JSON.parse(HTTP.get(link).body.to_s)
    return response['name'].blank?
    response = response['subs'][0]
    problem_id = response[1]
    verdict = uva_translate(response[2])
    unless Submission.find_by(
      trainee_id: trainee.id,
      problem_judge: 'live_archive',
      problem_id: problem_id,
      verdict: verdict
    )
      Submission.create(
        trainee_id: trainee.id,
        problem_judge: 'live_archive',
        problem_id: problem_id,
        verdict: verdict
      )
      if verdict == :accepted
        flash[:success] = 'Trainee #{trainee.name} solved problem #{problem_id}'
      end
    end
  end
  def spoj_submissions(trainee)
    link = "http://www.spoj.com/status/#{trainee.spoj_handle}/"
    doc = Nokogiri::HTML(open(link)).css('tbody')
    l = doc.css('tr')[0]
    problem_id = l.css('.sproblem').text.strip
    verdict = spoj_translate(l.css('.statusres').text.strip)
    unless Submission.find_by(
    trainee_id: trainee.id,
    problem_judge: 'spoj',
    problem_id: problem_id,
    verdict: verdict
    )
      Submission.create(
        trainee_id: trainee.id,
        problem_judge: 'spoj',
        problem_id: problem_id,
        verdict: verdict
      )
      if verdict == :accepted
        flash[:success] = 'Trainee #{trainee.name} solved problem #{problem_id}'
      end
    end
  end
  def timus_submissions(trainee)
    link = "http://acm.timus.ru/status.aspx?count=100"
    doc = Nokogiri::HTML(open(link))
    rows = doc.css('.even') + doc.css('.odd')
    rows.each do |r|
      author = r.css('.coder').text.strip
      if Trainee.find_by(timus_handle: author, tracking_status: 1)
        problem_id = r.css('.problem').text.strip
        verdict = r.css('.verdict_rj').text.strip
        if verdict.blank?
          verdict = r.css('.verdict_ac')
        end
        verdict = timus_translate(verdict)
      end
      unless Submission.find_by(
        trainee_id: trainee.id,
        problem_judge: 'timus',
        problem_id: problem_id,
        verdict: verdict
      )
        Submission.create(
          trainee_id: trainee.id,
          problem_judge: 'timus',
          problem_id: problem_id,
          verdict: verdict
        )
        if verdict == :accepted
          flash[:success] = 'Trainee #{trainee.name} solved problem #{problem_id}'
        end
      end
    end
  end
  def uri_submissions(trainee)
    link = "https://www.urionlinejudge.com.br/judge/en/profile/#{trainee.uri_handle}"
    doc = Nokogiri::HTML(open(link))
    problem_id = doc.css('tr')[1].css('.id').text.strip
    verdict = :accepted
    unless Submission.find_by(
        trainee_id: trainee.id,
        problem_judge: 'uri',
        problem_id: problem_id,
        verdict: verdict
      )
      Submission.create(
          trainee_id: trainee.id,
          problem_judge: 'uri',
          problem_id: problem_id,
          verdict: verdict
        )
      if verdict == :accepted
        flash[:success] = 'Trainee #{trainee.name} solved problem #{problem_id}'
      end
    end
  end
  def codechef_submissions(trainee)
    link = "https://www.codechef.com/users/#{trainee.codechef_handle}"
    doc = Nokogiri::HTML(open(link, 'User-Agent' => 'ruby'))
    # Content is not HTML but a JS script
  end

  private

  def codeforces_translate(verdict)
    if verdict == 'OK'
      :accepted
    elsif verdict == 'WRONG_ANSWER'
      :wrong_answer
    elsif verdict == 'COMPILATION_ERROR'
      :compile_error
    elsif verdict == 'RUNTIME_ERROR'
      :runtime_error
    elsif verdict == 'PRESENTATION_ERROR'
      :presentation_error
    elsif verdict == 'TIME_LIMIT_EXCEEDED'
      :time_limit
    elsif verdict == 'FAILED'
      :cant_be_judged
    elsif verdict == 'MEMORY_LIMIT_EXCEEDED'
      :memory_limit
    else
      :submission_error
    end
  end

  def uva_translate(verdict)
    if verdict == 10
      :submission_error
    elsif verdict == 15
      :cant_be_judged
    elsif verdict == 20
      :in_queue
    elsif verdict == 30
      :compile_error
    elsif verdict == 35
      :restricted_function
    elsif verdict == 40
      :runtime_error
    elsif verdict == 45
      :output_limit
    elsif verdict == 50
      :time_limit
    elsif verdict == 60
      :memory_limit
    elsif verdict == 70
      :wrong_answer
    elsif verdict == 80
      :presentation_error
    elsif verdict == 90
      :accepted
    end
  end
  def spoj_translate(verdict)
    if verdict == 'accepted'
      :accepted
    elsif verdict == 'time limit exceeded'
      :time_limit
    elsif verdict == 'compilation error'
      :compile_error
    elsif verdict == 'runtime error'
      :runtime_error
    elsif verdict.include? 'wrong answer'
      :wrong_answer
    end
  end
  def timus_translate(verdict)
    if verdict == 'Accepted'
      :accepted
    elsif verdict == 'Wrong answer'
      :wrong_answer
    elsif verdict == 'Memory limit exceeded'
      :memory_limit
    elsif verdict == 'Compilation error'
      :compile_error
    elsif verdict == 'Time limit exceeded'
      :time_limit
    elsif verdict.include? 'Runtime error'
      :runtime_error
    end
  end
end
