require 'docx'
require 'carrierwave/orm/activerecord'
require 'pathname'

require 'tempfile'
$foo = 'bar'
$contentsArray=[]  # start with an empty array
$name
$dump_name=''
$dump_title=[]
$final_title=[]
$tl_contents=[]
$terra_summary=[]

class WelcomeController < ApplicationController

    attr_accessor :original_filename
    attr_accessor :tempfile

  def index
    # @resumes = Resume.all
  end
  
  def login
    @result_error = ''

    if request.post?
      #Reading the params for email and password
      email = params[:email]
      password = params[:password]
      #Verifying the params not empty or not
      if email == "admin@terralogic.com" && password == "admin"
        session[:email] = email;
        #If condition satisfies, Store in session and redirect to another page
        redirect_to :controller => 'welcome',
        :action => 'dash_upload', :email => email, :password => password
      else # if values accepted and did not meet condition. It will come to else part
        @result_error = "Login Failed"
      end #params check end

    end # Request end

  end #login end




    
def dash_upload

  email = session[:email]
  if email.blank? 
    redirect_to :controller => 'welcome',
      :action => 'login'
  end
  

end



def logout

  puts "----------Inside logout------------"
  email = nil
  password = nil

  session[:email] = nil;
  redirect_to :controller => 'welcome',
  :action => 'login'


end


def uploadFile
#puts "Global value.............  #{$foo}"
 #$foo = "hyy ruby"
 #puts "Global value.............  #{$foo}"
 $final_title = []
 $dump_title = []
 $dump_name = ''
 $terra_summary = []
 $contentsArray= []
 $tl_contents= []

  #  if uploaded_io.original_filename.match /.docx/
  #    name = uploaded_io.original_filename
  #    upload(name)
# puts "Name!!!! #{name}"
#   else
#     flash[:error] = "Invalid Format. Please upload the file with .docx format"
#      redirect_to :controller => 'welcome',
#      :action => 'dash_upload'
#   end
#puts "Filename!!!!!!....#{uploaded_io.original_filename}"
   uploaded_io=params[:upload][:file]
   File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
   file.write(uploaded_io.read)
        if uploaded_io.original_filename.match /.docx/
          $name = uploaded_io.original_filename
          upload()
          redirect_to '/welcome/dash_upload.html'

          else

            flash[:error] = "Invalid Format. Please upload the file with .docx format"
              redirect_to :controller => 'welcome',
                :action => 'dash_upload'
            end
    end

end

  def upload()


    puts "----Inside Upload----"
    @str=""
  #  @contentsArray=[]  # start with an empty array
      #@doc=Docx::Document.open("/home/terralogic/Downloads/sagorcv.docx")
    
     puts "Filename #{$name}"

       @url = "/home/pc-swetha/Documents/rubyonrails/upload_resume/public/uploads/" 

    #   puts "Filename #{@file_name}"
    puts "URL #{@url}#{$name}"
    


       @doc=Docx::Document.open(@url+$name)


       @str=@doc.to_s
       $contentsArray=@str.split("\n")
    
     puts "Content:------#{$contentsArray}"
     match_pat()
  end

  

    
  # def match_pat()
  #  @keys=["CV","Cv","cv","RESUME","Resume","resume","Curriculum Vitae","CURRICULUM VITAE","CURRICULAM VITAE"]

  #  @name=[]
  
  #   for i in 0..4 do   #(@contentsArray.length-1)
  #    for j in 0..(@keys.length-1) do
     
  #      if $contentsArray[i].match(@keys[j])
  #         i+= 1 
  #         j=-1
  #      end
  #    end 
  #          @name[i]=$contentsArray[i]
  #    end
   
  #    for i in 0..(@name.length-1)
  #     if @name[i].blank? || @name[i].nil? || @name[i].empty?
  #      i+=1
  #     else
  #       $dump_name = @name[i]
  #     end
  #    end
   
  #    match_pat_title()

  # end #<----MATCH_PAT end----->


  def match_pat()
    @keys=["CV","Cv","cv","RESUME","Resume","resume","Curriculum Vitae","CURRICULUM VITAE","CURRICULAM VITAE"]
    
    @name=[]
    for i in 0..4 do #(@contentsArray.length-1)
    for j in 0..(@keys.length-1) do
    if $contentsArray[i].match(@keys[j])
    i+= 1
    j=-1
    end
    end
    @name[i]=$contentsArray[i]
    end
    for i in 0..(@name.length-1)
    if @name[i].blank? || @name[i].nil? || @name[i].empty?
    i+=1
    else
    $dump_name = @name[i]
    end
    end
    match_pat_title()
    
    end #<----MATCH_PAT end----->





  def match_pat_title()
  
    @match_title=["Career Objective" , "CAREER OBJECTIVE" , "OBJECTIVE:", "OBJECTIVE","Objective","Professional Experience", 
  "PROFESSIONAL EXPERIENCE" , "Educational Qualification" , "EDUCATIONAL QUALIFICATION" , 
  "Technical Profile" , "TECHNICAL PROFILE" , "Strengths" , "STRENGTHS" , 
   #"Declaration" , "DECLARATION" , 
  "PROFESSIONAL TRAINING" , "Professional Training" , "TECHNICAL SUMMARY" , 
  "Technical Summary" , "TECHNICAL SKILLS" , "Technical Skills" , "ACADEMIC PROFILE" ,
  "Academic Profile" , "PROJECTS" , "Projects" , "ACADEMIC RECORD:" , "ACADEMIC RECORD" , 
  "Academic Record" , "TRAININGS UNDERGONE:" , "TRAININGS UNDERGONE" , 
  "Trainings Undergone" , "Projects Details:" , "Projects Details" , "PROJECT DETAILS" ,
  "ACHIEVEMENTS AND ACTIVITIES:" , "ACHIEVEMENTS AND ACTIVITIES" , 
  "Achievements and Activities" , "SOFTWARE/OTHER SKILLS:" , "SOFTWARE/OTHER SKILLS" , 
  "Software Skills" , "SOFTWARE SKILLS" , "POTENTIAL ASSETS:" , "POTENTIAL ASSETS" , 
  "Potential Assets" 
  ]
     #puts "Keys:,#{@keys}, #{@keys.length}"
     #puts "Length:-----#{@contentsArray.length}"
     for i in 0..$contentsArray.length-1
        $contentsArray[i].gsub(/\n/,"")
        $contentsArray[i].delete(' ')
        if $contentsArray[i].match /^\w*[A-Z]\w*[A-Z]\w*/ 

          $dump_title.push $contentsArray[i]

        elsif  $contentsArray[i].match /\w*[A-Z]\w*/ and $contentsArray[i].length<30

          $dump_title.push $contentsArray[i]

        end
           # @title[i]=@contentsArray[i]
      end #end of for

      for i in 0..$dump_title.length-1
        for j in 0..@match_title.length-1
          if $dump_title[i] == @match_title[j]
            $final_title.push $dump_title[i]
          end
        end
      end
  
     # puts "Final Title : #{@final_title}"
     # puts "Titles: #{@dump_title}"
     # puts "Length:#{@contentsArray.length}"
      
      match_content()

   end #<----MATCH_PAT end---->

  def match_content()
    #@dump_name=dump_name
    #@final_title=final_title
    #puts "Inside match_content method"
    #puts "Final Name: #{@dump_name}"
    puts "Final Title: #{$final_title}"
    #puts "Final Content: #{@contentsArray}"

    @count=1
    for i in 0..$final_title.length-1
      for j in 0..$contentsArray.length-1
      if $contentsArray[j]==$final_title[i]
      
        while  j< $contentsArray.index($final_title[@count]).to_i  #@contentsArray.index(@final_title[i+=1]) #@contentsArray.index(@final_title[i+1]) # @contentsArray[j] == "Educational Qualification" do    #@final_title[i+1]
         # puts "Value of j:----#{@contentsArray.index(@final_title[@count]).to_i}"
         # puts "Value :---- #{@contentsArray[16]}"

          $terra_summary.push $contentsArray[j]
          j=j+1
        end                  
        end #----end of if
      end #------end of for j
      @count+=1
    end #------end of for i

    puts "\n terra name :---- #{$dump_name}"
    puts "Terra Summary: #{$terra_summary}"
    resumedownload()

   # puts "Summary: #{@terra_summary}"

   # tl_content()
   # tl_content1(@dump_name,@final_title,@terra_summary)


  end #<----match_content End----->


  # def tl_content()
  #   @tl_name
  #   @tl_summary = []
  #   #@tl_skills = []
  #   @tl_experience
  #   @tl_education = []

  #   @tl_name=dump_name

  #   for i in 0..$final_title.length-1
  #     for j in 0..$terra_summary.length-1
        
  #      if $final_title[i] == "Career Objective" or "CAREER OBJECTIVE" "OBJECTIVE:" or "OBJECTIVE" or "Objective"#---Working
  #         break if @terra_summary[j] == @final_title[i+1]
  #          @tl_summary.push @terra_summary[j].to_s
  #         j+=1
  #     end #----end of for if

  #     end ##----end of for j
  #     break
  #     #i+=1
  #  end #----end of for i
   
  #  puts "\n terra name :---- #{@tl_name}"
  #  puts "Terra Summary: #{@terra_summary}"

  #  resumedownload(@tl_name,@tl_summary)
  #    # puts "\n terra summary :---- #{@tl_summary}"
  # end 


  def resumedownload()
    
  
   # random_table = (0..50).map{|i|[*('a'..'z')]} # generate a 2D array for example (~2 pages)
    respond_to do |format|
      format.html
      format.pdf do
      pdf = Prawn::Document.new
      
     # pdf.table random_table
      header(pdf)
      table_content(pdf)
      footer(pdf)
      send_data pdf.render, filename: "#{$dump_name}.pdf" ,  
        type: 'application/pdf',
        disposition: 'inline'
      end
    end
  

  end
  
  def header pdf
    pdf.repeat :all do
       # pdf.stroke_bounds
        pdf.image "#{Rails.root}/app/assets/images/terralogic.png", :at => [40,745], :width => 140 
        pdf.move_down(50)

        #  pdf.text "#{@dump_address}"

    end
  end
  
  def footer pdf
    pdf.page_count.times do |i|
  
    pdf.bounding_box([pdf.bounds.left, pdf.bounds.bottom], :width => pdf.bounds.width, :height => 30) {
              # for each page, count the page number and write it
              pdf.go_to_page i+1
                   pdf.move_down 5 # move below the document margin
                   pdf.text "www.terralogic.com", :align => :center # write the page number and the total page count
              }
  end
  end
  
  def table_content pdf
   # puts tl_name
 #  pdf.move_down(50)
   pdf.font "Times-Roman"
   pdf.text "#{$dump_name.upcase}" ,:align => :center ,:style => :bold,:size => 19
   pdf.move_down(20)
   #pdf.draw_text "#{$dump_name}", at: [300, 380]
    pdf.text "#{$terra_summary.join("\n")}" 
   # pdf.text "#{$final_title}" 


    
      #  pdf.stroke_bounds
      
  end
  
 




#   def tl_content1(dump_name,final_title,terra_summary)
#     @tl_skills = []
#     @final_title1 = []
#     @final_title1 = final_title
#    for i in 0..@final_title.length-1
#     for j in 0..@terra_summary.length-1
      
#       if @final_title1[i] == "Technical Profile" or
#               "Technical Summary" or "TECHNICAL SKILLS" or "Technical Skills" 
#                "SOFTWARE/OTHER SKILLS:" or "SOFTWARE/OTHER SKILLS" or 
#                "Software Skills" or "SOFTWARE SKILLS" or "Technical Profile" or "TECHNICAL PROFILE"

#         puts "Value of I...#{@final_title[i]}"
#         break if @terra_summary[j] == @final_title1[i+1]

#          @tl_skills.push @terra_summary[j]
#         j+=1

#     end #----end of for if

#     end ##----end of for j
#     break
#  end #----end of for i
#  puts "\n terra skills :---- #{@tl_skills}"

# end

#  for i in 0..@final_title.length-1
#   for j in @terra_summary.index(@final_title[i+2]).to_i..@terra_summary.length-1
    
#     if @final_title[i] == "ACADEMIC RECORD:" or "ACADEMIC RECORD" or"Academic Record" #----not working
#       break if @terra_summary[j] == @final_title[i+3]

#        @tl_education.push @terra_summary[j]
#       j+=1

#   end #----end of for if

#   end ##----end of for j
#   break
# end #----end of for i


#    puts "\n terra name :---- #{@tl_name}"
#    puts "\n terra summary :---- #{@tl_summary}"
#    puts "\n terra skills :---- #{@tl_skills}"
#    puts "\n terra education :---- #{@tl_education}"
#    puts "\n"


#   end #tl_content end

#   def login
#   end
  
end #<----class end----->


 