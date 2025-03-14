//
//  BookViewModel.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 14/3/25.
//

import SwiftUI

class BookViewModel: ObservableObject {
    @Published var books: [Book] = [
        Book(id: UUID(), title: "Sonnet 3: Look in thy glass and tell the face thou viewest",
             author: ["William Shakespeare"],
             lines: ["Look in thy glass and tell the face thou viewest",
                     "Now is the time that face should form another;",
                     "Whose fresh repair if now thou not renewest,",
                     "Thou dost beguile the world, unbless some mother.",
                     "For where is she so fair whose unear'd womb",
                     "Disdains the tillage of thy husbandry?",
                     "Or who is he so fond will be the tomb,",
                     "Of his self-love to stop posterity?",
                     "Thou art thy mother's glass and she in thee",
                     "Calls back the lovely April of her prime;",
                     "So thou through windows of thine age shalt see,",
                     "Despite of wrinkles this thy golden time.",
                     "  But if thou live, remember'd not to be,",
                     "  Die single and thine image dies with thee."]),
        Book(id: UUID(), title: "Sonnet 7: Lo! in the orient when the gracious light",
             author: ["William Shakespeare"],
             lines: ["Lo! in the orient when the gracious light",
                     "Lifts up his burning head, each under eye",
                     "Doth homage to his new-appearing sight,",
                     "Serving with looks his sacred majesty;",
                     "And having climb'd the steep-up heavenly hill,",
                     "Resembling strong youth in his middle age,",
                     "Yet mortal looks adore his beauty still,",
                     "Attending on his golden pilgrimage:",
                     "But when from highmost pitch, with weary car,",
                     "Like feeble age, he reeleth from the day,",
                     "The eyes, 'fore duteous, now converted are",
                     "From his low tract, and look another way:",
                     "  So thou, thyself outgoing in thy noon:",
                     "  Unlook'd, on diest unless thou get a son."]),
    ]
}
