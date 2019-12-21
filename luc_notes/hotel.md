### I - Summarize
1) based on destination_ids to merge data
2) based on destination_ids and hotel_ids to search
3) Images are working so just organise them
4) Just need some simple rules instead of AI

### II - Bonus
1) Automation tests
2) CI/CD
3) Auto deploy (K8s and google cloud)
4) Building imagesbundle update

### III - Sample data
#### 1) Hotel tables
- hotel_id: integer, required, uniqueness, index: true (["iJhz", "SjyX"])
- destination id: integer, required, uniqueness, index: true
- name: string, required, strip_rb for display
- description: text, strip_rb for display
- detail: text, strip_rb for display, consider as description (info)
- address: is address object
    + id: integer
    + address: string, required
    + country: string, required
    + city: string, optional
    + postal_code: string, optional
    + latitude: float, optional (lat)
    + longitude: float, optional (lng)
- facilities: is facilities object ["BusinessCenter", " Breakfast",  "DryCleaning"]
- amenities: is facilities object ["business center"]
    + id: integer
    + name: string, required
    + type: 1, 2 (room: ["tv"], general: ["indoor pool])
- images_room: hotel_image obj
- images_site: hotel_image obj
- images_amenities: hotel_image obj
    + id: integer
    + link: string, required (url)
    + caption: optional (description)
    
- booking_conditions: booking_condition_obj
    + condition: text, required

### Questions 
- 2) filtered in either option: **hotel_ids** and **destination**
- Question2: **destination** should be ids for more flexible?, any special requirement here?
