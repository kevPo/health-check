# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Category.create([
  { 
    name: 'Delivering Value', 
    awesome: 'We deliver great stuff! We’re proud of it and our stakeholders are really happy.', 
    crappy: 'We deliver crap. We feel ashamed to deliver it. Our stakeholders hate us.', 
    default: true 
  },
  {
    name: 'Easy to Release',
    awesome: 'Releasing is simple, safe, painless and mostly automated.',
    crappy: 'Releasing is risky, painful, lots of manual work and takes forever.',
    default: true
  },
  {
    name: 'Fun',
    awesome: 'We love going to work and have great fun working together!',
    crappy: 'Boooooooring...',
    default: true
  },
  {
    name: 'Health of Codebase',
    awesome: 'We’re proud of the quality of our code! It is clean, easy to read and has great test coverage.',
    crappy: 'Our code is a pile of dung and technical debt is raging out of control.',
    default: true
  },
  {
    name: 'Learning',
    awesome: 'We’re learning lots of interesting stuff all the time.',
    crappy: 'We never have time to learn anything.',
    default: true
  },
  {
    name: 'Mission',
    awesome: 'We know exactly why we are here and we’re really excited about it!',
    crappy: 'We have no idea why we are here, there’s no high lever picture or focus. Our so called mission is completely unclear and uninspiring.',
    default: true
  },
  {
    name: 'Pawns or Players',
    awesome: 'We are in control of our own destiny! We decide what to build and how to build it.',
    crappy: 'We are just pawns in a game of chess with no influence over what we build or how we build it.',
    default: true
  },
  {
    name: 'Speed',
    awesome: 'We get stuff done really quickly! No waiting and no delays.',
    crappy: 'We never seem to get anything done. We keep getting stuck or interrupted. Stories keep getting stuck on dependencies.',
    default: true
  },
  {
    name: 'Suitable Process',
    awesome: 'Our way of working fits us perfectly.',
    crappy: 'Our way of working sucks!',
    default: true
  },
  {
    name: 'Support',
    awesome: 'We always get great support and help when we ask for it!',
    crappy: 'We keep getting stuck because we can’t get the support and help that we ask for.',
    default: true
  },
  {
    name: 'Teamwork',
    awesome: 'We are a totally gelled super-team with awesome collaboration!',
    crappy: 'We are a bunch of individuals that neither know nor care about what the other people in the squad are doing.',
    default: true
  }
])