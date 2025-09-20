# Fluencify

Fluencify is an iOS language learning app developed as my final year dissertation project at the University of Liverpool.  
It is designed to **break language barriers** by combining **structured lessons, gamification, and accessibility** to make learning engaging and effective.  
The app currently supports **Spanish** and **Italian**.

---

## ✨ Features

- **Onboarding & Difficulty Selection**  
  - Beginner, Intermediate, and Advanced learning paths.  
  - User preferences stored with `UserDefaults` for a seamless experience.  

- **Language Switching**  
  - Switch instantly between Spanish and Italian in the Home screen.  

- **Chapter-Based Lessons**  
  - Content stored in structured text files.  
  - Includes standard lessons plus unique chapters such as **slang** for real-world usage.  

- **Quizzes & Boss Fights**  
  - Multiple-choice quizzes reinforce vocabulary.  
  - Gamified **Boss Fights** act as checkpoints, using text-to-speech audio from native voices.  
  - XP system with progression, lives, and rewards.  

- **Tap-to-Speak with AVFoundation**  
  - Built-in **text-to-speech** for pronunciation practice.  
  - Uses carefully chosen voices (e.g. *Federica* for Italian, *Monica* for Spanish) for natural output.  

- **Gamification Elements**  
  - XP, levels, ranks, lives, and challenges inspired by video games.  
  - Progression system keeps users motivated.  

---

## 📸 Screenshots / Mockups

*(Add simulator screenshots here to showcase the app — onboarding, home screen, quizzes, and boss fights.)*

<p align="center">
  <img src="screenshots/onboarding.png" width="200" alt="Onboarding">
  <img src="screenshots/home.png" width="200" alt="Home Screen">
  <img src="screenshots/learn.png" width="200" alt="Learn Tab">
  <img src="screenshots/quiz.png" width="200" alt="Quiz/Boss Fight">
</p>

---

## 🛠 Tech Stack

- **Language:** Swift 5  
- **Frameworks:** UIKit, AVFoundation  
- **Architecture:** MVC  
- **Persistence:** UserDefaults (local, no personal data stored)  
- **Platform:** iOS 14+  

---

## 📂 Project Structure

```
AppDelegate.swift
SceneDelegate.swift             # Onboarding logic
HomeScreenViewController.swift  # Language switching
LearnViewController.swift       # Chapter navigation
ChaptContentViewController.swift # Lesson content with TTS
ChooseDifficulty.swift
UserPreferences.swift           # Persistence (language, XP, achievements)
Chapters + Content files        # SpanishChapters.txt, ItalianChapters.txt
TrophiesViewController.swift    # Placeholder for achievements
```

---

## 🧪 Testing & Evaluation

- **Manual Testing:** Each feature was tested via breakpoints, print statements, and simulator runs.  
- **Focus Areas:** Onboarding, navigation, XP progression, text-to-speech.  
- **Results:** Smooth navigation between lessons and boss fights, accurate XP calculations, persistent user data.  
- **Limitations:** Testing was manual only; future work should include automated unit/UI tests using XCTest.    

---

## 🚀 Future Work

Planned features include:  
- Daily challenges and streak systems.  
- Expanded quiz types (fill-in-the-blank, audio recognition).  
- Additional languages beyond Romance (Germanic, Slavic, etc.).  
- Cloud sync for progress.  
- More interactive trophies/achievements.   

---

## 📜 Conclusion

Fluencify demonstrates how **Swift and iOS frameworks** can be used to create a scalable, gamified, and accessible language learning app.  
It successfully integrates **quizzes, boss fights, TTS, and gamification mechanics** to engage learners, while remaining lightweight and flexible.  
The app provides a strong foundation for future development and expansion.   

---

## 👨‍💻 Author

**Iacopo Boaron Otero**  
Dissertation Project – BSc Computer Science  
University of Liverpool
