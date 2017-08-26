
desc 'データを取得するページを開く'
task default: :clean do
  sh "open https://peatix.com/event/272173/list_sales#"
end

desc '集計して、コピーしては貼り付けるページを開く'
task main: ['tmp/nite.csv', :sum, :open_cybouzuline]
task :open_cybouzuline do
  sh "open https://cybozulive.com/1_341662/gwBoard/view?bid=1%3A5744478&boffset=0&currentFolderId="
end

questions_file = "tmp/questions.txt"
desc 'アンケートを集計してコピーして貼り付けるページを開く'
task sub: [:questions_copy, :open_cybouzuline]

task questions_copy: questions_file do
  sh "cat #{questions_file} | pbcopy"
end

task :clean do
  rm_rf "tmp"
  sh 'rm ~/Downloads/CSS\\ Nite\\ in\\ HIROSHIMA,\\ Vol.10*.csv || echo'
end

file "tmp/nite.csv" do
  mkdir 'tmp'
  sh 'mv ~/Downloads/CSS\\ Nite\\ in\\ HIROSHIMA,\\ Vol.10*.csv tmp/nite.csv || echo'
end

file "tmp/normalize.csv" => "tmp/nite.csv" do
  sh "nkf -w tmp/nite.csv | sed -e '1d' > tmp/normalize.csv"
end

task sum: "tmp/normalize.csv" do
  sh "cat tmp/normalize.csv | q -tq sum.sql > tmp/sum.txt"
  sh "cat tmp/sum.txt"
  sh "cat tmp/sum.txt | pbcopy"
end

sex_file = "tmp/sex.txt"
file sex_file  => "tmp/normalize.csv" do
  file_name = sex_file
  seq_sql = "SELECT #{field(16)} as sex, count(*) as c from tmp/normalize.csv group by sex ORDER BY c DESC"
  sh "echo - 性別 > #{file_name}"
  sh "q -t '#{seq_sql}' >> #{file_name}"
  sh "cat #{file_name}"
end

age_file = "tmp/age.txt"
file age_file => "tmp/normalize.csv" do
  file_name = age_file
  seq_sql = "SELECT #{field(17)} as age, count(*) as c from tmp/normalize.csv group by age ORDER BY age"
  sh "echo - 年代 > #{file_name}"
  sh "q -t '#{seq_sql}' >> #{file_name}"
  sh "cat #{file_name}"
end

address_file = "tmp/address.txt"
file address_file  => "tmp/normalize.csv" do
  file_name = address_file
  seq_sql = "SELECT #{field(18)} as address, count(*) as c from tmp/normalize.csv group by address ORDER BY c DESC"
  sh "echo - お住まい > #{file_name}"
  sh "q -t '#{seq_sql}' >> #{file_name}"
  sh "cat #{file_name}"
end

job_file = "tmp/job.txt"
file job_file => "tmp/normalize.csv" do
  file_name = job_file
  seq_sql = "SELECT #{field(19)} as target, count(*) as c from tmp/normalize.csv group by target ORDER BY c DESC"
  sh "echo - 勤務先 > #{file_name}"
  sh "q -t '#{seq_sql}' >> #{file_name}"
  sh "cat #{file_name}"
end

worker_file = "tmp/worker.txt"
file worker_file => "tmp/normalize.csv" do
  file_name = worker_file
  seq_sql = "SELECT  #{field(21)} as target, count(*) as c from tmp/normalize.csv group by target ORDER BY c DESC"
  sh "echo - 雇用形態 > #{file_name}"
  sh "q -t '#{seq_sql}' >> #{file_name}"
  sh "cat #{file_name}"
end

work_file = "tmp/work.txt"
file work_file => "tmp/normalize.csv" do
  file_name = work_file
  seq_sql = "SELECT  #{field(22)} as target, count(*) as c from tmp/normalize.csv group by target ORDER BY c DESC"
  sh "echo - 主な業務 > #{file_name}"
  sh "q -t '#{seq_sql}' >> #{file_name}"
  sh "cat #{file_name}"
end


event_file = "tmp/event.txt"
file event_file => "tmp/normalize.csv" do
  file_name = event_file
  seq_sql = "SELECT  #{field(23)} as target, count(*) as c from tmp/normalize.csv group by target ORDER BY c DESC"
  sh "echo - CSS Nite in HIROSHIMAへの参加 > #{file_name}"
  sh "q -t '#{seq_sql}' >> #{file_name}"
  sh "cat #{file_name}"
end

questions = [sex_file, age_file, address_file, job_file, worker_file, work_file, event_file]
file questions_file => questions do
  sh "echo 参加者属性 > #{questions_file}"
  sh "echo >> #{questions_file}"
  questions.each do |q|
    sh "cat #{q} >> #{questions_file}"
    sh "echo >> #{questions_file}"
  end
end

def field(n)
  target = "c#{n} || c#{n+15}"
  %Q!CASE #{target} WHEN "" THEN "未回答" ELSE #{target} END!
end
