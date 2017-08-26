
desc 'データを取得するページを開く'
task default: :clean do
  sh "open https://peatix.com/event/272173/list_sales#"
end

desc '集計して、コピーしては貼り付けるページを開く'
task main: ['tmp/nite.csv', :sum, :open_cybouzuline]
task :open_cybouzuline do
  sh "open https://cybozulive.com/1_341662/gwBoard/view?bid=1%3A5744478&boffset=0&currentFolderId="
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
