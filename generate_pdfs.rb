total = Book.count

Book.find_each.with_index do |book, index|
  if book.pdf_path.nil?
    url = URI.parse('https://baconipsum.com/api/?type=meat-and-filler')
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port, use_ssl: true) { |http|
      http.request(req)
    }
    pdf_text = res.body.to_s[2...res.body.to_s.size-2]
    Prawn::Document.generate("#{Rails.root}/public/pdfs/#{book.slug}.pdf") do
      text pdf_text
    end
    puts "Generated #{book.slug}.pdf #{index}/#{total}"
    book.pdf_path = "#{Rails.root}/public/pdfs/#{book.slug}.pdf"
    book.save
  end
end
