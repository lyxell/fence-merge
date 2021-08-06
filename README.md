## fence-merge

If we consider half-fences in isolation there's really only three
cases:

Case 1, variation 1:
```
x
---
```

Case 1, variation 2:
```
---
x
```

Case 2, variation 1:
```
x
---  x
```

Case 2, variation 2:
```
---   x
x
```

Case 3:
```
x
---   x
x
```

---

<img src="https://raw.githubusercontent.com/lyxell/fence-merge/main/figures/figure1.svg">

---

<img src="https://raw.githubusercontent.com/lyxell/fence-merge/main/figures/figure2.svg">

---

Motivating example:

```java
// ORIGINAL
import java.util.stream.Collectors;
import java.util.List;
import java.util.ArrayList;

public class TestMethod {
    public List<Integer> getNumbers() {
        return List.of(-10, -5, 0, 1, 3, 9);
    }
    public List<Integer> getPositiveNumbers() {
        List<Integer> positiveNumbers = new ArrayList<>(getNumbers().stream().filter(i -> i > 0).collect(java.util.stream.Collectors.toList()));
        return positiveNumbers;
    }
}

//CANDIDATE
import java.util.stream.Collectors;
import java.util.List;
import java.util.ArrayList;

public class TestMethod {
    public List<Integer> getNumbers() {
        return List.of(-10, -5, 0, 1, 3, 9);
    }
    public List<Integer> getPositiveNumbers() {
        List<Integer> positiveNumbers = getNumbers().stream().filter(i -> i > 0).collect(java.util.stream.Collectors.toList());
        return positiveNumbers;
    }
}

//CANDIDATE
import java.util.stream.Collectors;
import java.util.List;
import java.util.ArrayList;

public class TestMethod {
    public List<Integer> getNumbers() {
        return List.of(-10, -5, 0, 1, 3, 9);
    }
    public List<Integer> getPositiveNumbers() {
        return new ArrayList<>(getNumbers().stream().filter(i -> i > 0).collect(java.util.stream.Collectors.toList()));
    }
}

//CANDIDATE
import java.util.stream.Collectors;
import java.util.List;
import java.util.ArrayList;

public class TestMethod {
    public List<Integer> getNumbers() {
        return List.of(-10, -5, 0, 1, 3, 9);
    }
    public List<Integer> getPositiveNumbers() {
        List<Integer> positiveNumbers = new ArrayList<>(getNumbers().stream().filter(i -> i > 0).collect(Collectors.toList()));
        return positiveNumbers;
    }
}
```
