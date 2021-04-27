# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Genre.create!([{ name: 'Fantasy' }, { name: 'Classical' }, { name: 'Sci-Fi' }, { name: 'Adventure' }, \
              { name: 'Comic' }, { name: 'Detective' }, { name: 'Historical' }, \
              { name: 'Horror' }, { name: 'Romance' }])
Author.create!([{ name: 'William Shakespeare' },
                { name: 'Agatha Christie' },
                { name: 'Barbara Cartland' },
                { name: 'Danielle Steel' },
                { name: 'Harold Robbins' },
                { name: 'Georges Simenon' },
                { name: 'Enid Blyton' },
                { name: 'Sidney Sheldon' },
                { name: 'J. K. Rowling' }])

# Authors
shakespear = Author.where(name: 'William Shakespeare').first
christie = Author.where(name: 'Agatha Christie').first
steel = Author.where(name: 'Danielle Steel').first
dobbins = Author.where(name: 'Harold Robbins').first
simenon = Author.where(name: 'Georges Simenon').first
blyton = Author.where(name: 'Enid Blyton').first
sheldon = Author.where(name: 'Sidney Sheldon').first
rowling = Author.where(name: 'J. K. Rowling').first

# Genres
fantasy = Genre.where(name: 'Fantasy').first
classical = Genre.where(name: 'Classical').first
scifi = Genre.where(name: 'Sci-Fi').first
adventure = Genre.where(name: 'Adventure').first
comic = Genre.where(name: 'Comic').first
detective = Genre.where(name: 'Detective').first
historical = Genre.where(name: 'Historical').first
horror = Genre.where(name: 'Horror').first
romance = Genre.where(name: 'Romance').first

# Books creation
hamlet = Book.create!(name: 'Hamlet', image_url: 'https://d188rgcu4zozwl.cloudfront.net/content/B07VMPFCKM/resources/1574674465',
                      description: "The Tragedy of Hamlet, Prince of Denmark, often shortened to Hamlet (hæmlɪt), is a tragedy written by William Shakespeare sometime between 1599 and 1601. It is Shakespeare's longest play, with 29,551 words. Set in Denmark, the play depicts Prince Hamlet and his revenge against his uncle, Claudius, who has murdered Hamlet's father in order to seize his throne and marry Hamlet's mother. Hamlet is considered among the most powerful and influential works of world literature, with a story capable of 'seemingly endless retelling and adaptation by others'. It was one of Shakespeare's most popular works during his lifetime and still ranks among his most performed, topping the performance list of the Royal Shakespeare Company and its predecessors in Stratford-upon-Avon since 1879. It has inspired many other writers—from Johann Wolfgang von Goethe and Charles Dickens to James Joyce and Iris Murdoch—and has been described as 'the world's most filmed story after Cinderella'. The story of Shakespeare's Hamlet was derived from the legend of Amleth, preserved by 13th-century chronicler Saxo Grammaticus in his Gesta Danorum, as subsequently retold by the 16th-century scholar François de Belleforest. Shakespeare may also have drawn on an earlier Elizabethan play known today as the Ur-Hamlet, though some scholars believe Shakespeare wrote the Ur-Hamlet, later revising it to create the version of Hamlet that exists today. He almost certainly wrote his version of the title role for his fellow actor, Richard Burbage, the leading tragedian of Shakespeare's time. In the 400 years since its inception, the role has been performed by numerous highly acclaimed actors in each successive century.")
hamlet.genres << classical
hamlet.authors << shakespear
potter = Book.create!(name: 'Harry Potter', image_url: 'https://images-na.ssl-images-amazon.com/images/I/91l1Op79AWL.jpg',
                      description: "Harry Potter is a series of seven fantasy novels written by British author, J. K. Rowling. The novels chronicle the lives of a young wizard, Harry Potter, and his friends Hermione Granger and Ron Weasley, all of whom are students at Hogwarts School of Witchcraft and Wizardry. The main story arc concerns Harry's struggle against Lord Voldemort, a dark wizard who intends to become immortal, overthrow the wizard governing body known as the Ministry of Magic and subjugate all wizards and Muggles (non-magical people). Since the release of the first novel, Harry Potter and the Philosopher's Stone, on 26 June 1997, the books have found immense popularity, positive reviews, and commercial success worldwide. They have attracted a wide adult audience as well as younger readers and are often considered cornerstones of modern young adult literature. As of February 2018, the books have sold more than 500 million copies worldwide, making them the best-selling book series in history, and have been translated into eighty languages. The last four books consecutively set records as the fastest-selling books in history, with the final instalment selling roughly eleven million copies in the United States within twenty-four hours of its release.")
potter.genres << adventure
potter.genres << fantasy
potter.authors << rowling
murder = Book.create!(name: 'The Murder of Roger Ackroyd', image_url: 'https://d188rgcu4zozwl.cloudfront.net/content/B01NARUK3U/images/cover.jpg',
                      description: "The Murder of Roger Ackroyd is a work of detective fiction by British writer Agatha Christie, first published in June 1926 in the United Kingdom by William Collins, Sons and in the United States by Dodd, Mead and Company. It is the third novel to feature Hercule Poirot as the lead detective. Poirot retires to a village near the home of a friend, Roger Ackroyd, to pursue a project to perfect vegetable marrows. Soon after, Ackroyd is murdered and Poirot must come out of retirement to solve the case. The novel was well-received from its first publication. In 2013, the British Crime Writers' Association voted it the best crime novel ever. It is one of Christie's best known and most controversial novels, its innovative twist ending having a significant impact on the genre. Howard Haycraft included it in his list of the most influential crime novels ever written. The short biography of Christie which is included in 21st century UK printings of her books calls it her masterpiece, although writer and critic Robert Barnard has written that he considers it a conventional Christie novel.")
murder.genres << detective
murder.authors << christie
royal = Book.create!(name: 'Royal', image_url: 'https://d188rgcu4zozwl.cloudfront.net/content/B081Y4MM12/resources/314890188',
                     description: "As the war rages on in the summer of 1943, causing massive destruction and widespread fear, the King and Queen choose to quietly send their youngest daughter, Princess Charlotte, to live with a trusted noble family in the Yorkshire countryside. Despite her fiery, headstrong nature, the princess's fragile health poses far too great a risk for her to remain in war-torn London. Third in line to the throne, seventeen year-old Charlotte reluctantly uses an alias upon her arrival in Yorkshire, her two guardians the only keepers of her true identity. A talented horsewoman, Charlotte begins to enjoy life out of the spotlight, concentrating on training with her beloved horse. But no one predicts that in the coming months she will fall deeply in love with her protectors' son. Far from her parents, a tragic turn of events leaves an infant orphaned. Alone in the world, that child will be raised in the most humble circumstances by a modest stable manager and his wife. No one, not even she, knows of her lineage. But when a stack of hidden letters comes to light, a secret kept for nearly two decades finally surfaces, and a long lost princess emerges.")
royal.genres << historical
royal.authors << steel
carpetbaggers = Book.create!(name: 'The Carpetbaggers', image_url: 'https://d188rgcu4zozwl.cloudfront.net/content/B00AJGNIL8/images/cover.jpg',
                             description: "The Carpetbaggers is a 1961 bestselling novel by Harold Robbins, which was adapted into a 1964 film of the same title. The prequel Nevada Smith (1966) was also based on a character in the novel. In the United States, the term 'carpetbagger' refers to an outsider relocating to exploit locals. It derives from postbellum American South usage, where it referred specifically to opportunistic Northerners who flocked to the occupied southern states in hopes of increasing their political, financial and social power during the Reconstruction era. In Robbins' novel, the exploited territory is the movie industry, and the newcomer is a wealthy heir to an industrial fortune who, like Howard Hughes, simultaneously pursued aviation and moviemaking avocations.")
carpetbaggers.genres << romance
carpetbaggers.authors << dobbins
maigret = Book.create!(name: 'Maigret and the Calame report', image_url: 'https://images-na.ssl-images-amazon.com/images/I/51A9FRH5F0L.jpg',
                       description: "M. Mostaguen, the wine dealer at Concarneau, is wounded by a gunshot when returning home drunk from the local Admiral Hotel and Maigret, who is organizing the mobile squad in Rennes, is called in by the Mayor to solve the crime. Maigret settles down at the hotel and discovers a set of curious characters who include Jean Servières, a retired newspaper man from Paris; Ernest Michoux, a doctor who has never practiced; Emma, the mysterious and complicated waitress at the hotel, and a strange yellow dog that seems to be haunting the neighborhood. The customs official is shot in the leg, Servières disappears and is found and brought back, and a giant vagrant is arrested before Maigret solves the case.")
maigret.genres << scifi
maigret.authors << simenon
stories = Book.create!(name: 'Stories of Pixies and Elves', image_url: 'https://images-na.ssl-images-amazon.com/images/I/716LcDg2dKL.jpg',
                       description: "The first of twenty-eight books in Blyton's Old Thatch series, The Talking Teapot and Other Tales, was published in 1934, the same year as Brer Rabbit Retold; (note that Brer Rabbit originally featured in Uncle Remus stories by Joel Chandler Harris), her first serial story and first full-length book, Adventures of the Wishing-Chair, followed in 1937. The Enchanted Wood, the first book in the Faraway Tree series, published in 1939, is about a magic tree inspired by the Norse mythology that had fascinated Blyton as a child. According to Blyton's daughter Gillian the inspiration for the magic tree came from 'thinking up a story one day and suddenly she was walking in the enchanted wood and found the tree. In her imagination she climbed up through the branches and met Moon-Face, Silky, the Saucepan Man and the rest of the characters. She had all she needed.' As in the Wishing-Chair series, these fantasy books typically involve children being transported into a magical world in which they meet fairies, goblins, elves, pixies and other mythological creatures.")
stories.genres << comic
stories.authors << blyton
sands = Book.create!(name: 'The Sands of Time', image_url: 'https://d188rgcu4zozwl.cloudfront.net/content/B003P2WOGS/images/cover.jpg',
                     description: "In Pamplona, Spain in 1976, the Basque people are fighting against the Spanish government for their rights to autonomy. ETA leader Jaime Miro, along with friends Ricardo Mellado and Felix Carpio, escape from prison, but at the expense of many civilian lives during a sabotaged bull-running exhibit that was used as a distraction from the police. Following the event, the Prime Minister assigns Colonel Ramón Acoca (head of the anti-ETA group GOE) to hunt down Jaime Miró; Acoca's wife and unborn child were killed in a Basque demonstration assisted by ETA and the Church, so when he suspects Jaime hiding in a convent, he decides to raid it by force despite the implications of it.")
sands.genres << horror
sands.authors << sheldon

Subscription.create([
                      {
                        name: 'Basic',
                        price: Money.from_amount(5, 'USD'),
                        month_limit: 30
                      },
                      {
                        name: 'Advanced',
                        price: Money.from_amount(10, 'USD'),
                        month_limit: 80
                      },
                      {
                        name: 'Pro',
                        price: Money.from_amount(15, 'USD'),
                        month_limit: 150
                      }
                    ])
