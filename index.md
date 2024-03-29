# Preface {.unnumbered}

![A nutshell of little (statistics) stars](img/stern.png){width="15%"}

## Welcome!

This is an introductory course on *statistical modelling*. Welcome!

The *focus of this course* is on how to specify a theoretical idea (possibly vague) in a testable statistical model.



## Please read me


In order to benefit as much as possible from this course, it is necessary for you to read this preface information. Yoda agrees (s. @fig-yoda).

![Yoda finds you should read the manual](img/yoda.jpg){#fig-yoda width="50%"}

## PDF-Version


Use the print button of your browser to print the html page into a PDF page.



## Course description

Analyzing research data can broadly be classified in three parts: explorative data analysis, modeling (including inference), and visualization. Either part is pivotal in its own right, but it can be argued that modeling is at the core of the scientific endeavor. However, in practice, modeling, visualization, and data exploration is heavily intertwined, so that three parts may be recognized (as individual entities) but not usefully separated from each other. This idea provides the rationale of this course: Data exploration, data visualization and data modeling is discussed as an integrated framework.

The focus is on practical data analysis; theoretical concepts are, where mentioned, second class citizens due to time constraints and the didactic aims of the course.

For example, statistical inference -- such as p-values and confidence intervals -- are not more than touched briefly, as the instructor believes that modeling, not inference, is of prime importance for the auditorium.

We will use the R environment for all computations (freely available). Please bring your own Laptop with R and RStudio installed (installation guides are provided). Data and R code will be provided.

## We're on a crash course

The course is set-up as a "crash course" which indicates that we'll rather try to cover a breadth of steps rather than digging deep at certain particular points. The rationale of this approach is that before digging deep, it is necessary to gain an overview of the territory. In addition, if one particular topic is not of interest to a given student (perhaps to difficult/simple), not much time is lost.

*Be warned*! Compare this crash course to a dancing crash course right before your wedding: A lot can be achieved by such a course in some instances, or rather, the worst consequences (of not knowing how to dance) may be fenced off, but one should not expect to be a dancing queen (king) thereafter.

## More on modelling

Models and modeling are of pivotal importance in many sciences, not only for providing an explanation of nature en miniature (theoretical models), but also for gauging how closely the empirical data at hand match the theoretical model. Translating a theoretical model into statistical language is called statistical modeling and provides the guiding principle in this introductory course. Regression models will be presented as a lingua franca of statistical modeling, and we will learn that many empirical questions can (comfortably) be analyzed using a regression framework. Depending on the background and aims of the participants (and time permitting), we will shed light on some standard topics such as model comparison, classification models, and typical pitfalls. Given a more advanced auditorium, we may want to explore how causal and non-causal associations can be translated and tested using simple linear statistical models. Foundational ideas of statistical modeling will be accompanied by short examples and case studies to facilitate transfer and practical application after the course.

## Course prerequisites

Basic *computer usage knowledge* is needed (downloading materials from the internet, operating a PC, etc). *Basic R knowledge* is needed. *Basic knowledge of statistical concepts (such as descriptive statistics) *is needed. *Willingness to learn* is essential.

## Learning objectives

Upon successful completion of this course, students should be able to:

-   select the right statistical visualization for a variety of data contexts
-   "crunch" or "wrangle" data
-   explain what statistical modeling means
-   formulate basic statistical models
-   differentiate between predictive and explanatory modeling
-   apply the methods to own datasets

## Course Literature

This course builds on the freely available e-book [ModernDive](https://moderndive.com/index.html). Each topic is paralleled by an accompanying chapter from ModernDive. A hard copy can be purchased [here](https://moderndive.com/index.html). The book is for sale in print [here](https://www.routledge.com/Statistical-Inference-via-Data-Science-A-ModernDive-into-R-and-the-Tidyverse/Ismay-Kim/p/book/9780367409821?utm_source=crcpress.com&utm_medium=referral).

## Course logistics

This course can be presented as a one-day seminar or split-up in two or more blocks.

The course can be held in English or German.

Please *bring your own computer* and *read the notes* regarding course logistics in advance. Note that some *upfront preparation is needed* from the learners.

R and RStudio[^index-1] will be needed throughout the course. Please make sure that the IT is running. In case of technical difficulties with R feel free to use [RStudio Cloud](https://rstudio.cloud/); free plans are available.

[^index-1]: Desktop version, not the server

All learning materials (such as literature, code, data) will be provided in electronic format.

## UPFRONT student preparation

-   *Install R and RStudio*, see [ModernDive Chap. 1.1](https://moderndive.com/1-getting-started.html#r-rstudio). In case you have your R running on your system, please make sure that you're uptodate. If outdated, download and install the most recent versions of the software. Similarly, hit the "Update" button in RStudio's "Packages" tab to update your packages if you have not done so for a couple of months.

-   Sign-in at [RStudio Cloud](https://login.rstudio.cloud/). It's super helpful because I as the techer can provide you with an environment where all R stuff is ready to use (packages installed etc).

-   Install the *necessary R packages* as used in the book chapters covered in this course (see the sections on "Needed packages" in each chapter). If in doubt, see [here](https://moderndive.com/1-getting-started.html#packages) the instructions on how to install R packages. [Here's](#packages) the actual list on the R packages we'll need.

-   Students new to R are advised to learn the basics, see [ModernDive, Chap 1.2 - 1.5](https://moderndive.com/1-getting-started.html#code)

-   Bring your own laptop

-   Make sure your internet connection is stable and your loudspeaker/headset is working; a webcam is helpful.

-   Students are advised to review the course materials after each session.

-   I recommend that you carefully check the course description to make sure the course fits your needs (not too advanced/basic).




## Didactic outline

This course can rather be considered a workshop in the sense that the instructor uses a dialogue-based approach to teaching and that there are numerous exercises during the course. Instead of providing long talks to the students, the instructor feels obligated to engage students in back-and-forth conversations. Similarly, the presentation of a large number of Powerpoint slide is avoided. Instead, a thorough course literature is available (free online), so that students will have no barrier in diving deeply into the materials and ideas presented. However, during class it is more important to transmit the pivotal ideas; details need to be read and worked by the students individually after (and before) the course. As an alternative to presenting a lot of text on slides, in this course there will be a (electronic) whiteboard where concepts are developed dynamically and in pace of the teaching conversation thereby adjusting the "dose" of new thoughts to the actual pace of the instruction.

## Schedule

### Overview on topics covered

-   Data Visualization using the grammar of graphics and ggplot2
-   Data Wrangling based on the tidyverse in R
-   Basic concepts of statistical modelling
-   Primer on causal inference
-   Introduction to regression analysis

### Block 1: Explorative Data Analysis

#### Visualization

-   Data *visualization*, see [ModernDive Chap. 2](https://moderndive.com/2-viz.html), and get the R code [here](http://moderndive.com/scripts/02-visualization.R)
    -   Exploring common types of statistical diagrams, the "5NG"
    -   Discussing when (not) to use diagrams [see Anscombe's Quartett](https://public.tableau.com/profile/dan.murray#!/vizhome/AnscombesQuartet_16/AnscombesQuartet), and when to use which one
    -   Building elegant graphics in R

#### Data Wrangling

-   Data *wrangling*, see [ModernDive Chap. 3](https://moderndive.com/3-wrangling.html), and get the R code [here](http://moderndive.com/scripts/03-wrangling.R)
    -   A taxonomy of typical data operations
    -   How to perform common data operations with R
    -   Summarizing data (aka computing descriptive statistics)

#### Exercises / Case study

-   Exercises
    -   Exercises on [life expectancy](https://data-se.netlify.app/2021/02/24/exercises-to-data-wrangling-with-the-tidyverse).
    -   Case study on the visualization of [flight delays](https://data-se.netlify.app/2021/02/24/exercises-no-solutions-data-vizualization-on-flight-delays-using-tidyverse-tools/)
    -   Advanced case study on [one hit wonders](https://www.njtierney.com/post/2017/11/07/tidyverse-billboard/)
    -   Visualization [covid cases](https://www.njtierney.com/post/2020/10/11/times-scales-covid/)
    -   Case study on nominal data: [Survival on the Titanic](https://www.kaggle.com/headsortails/tidy-titarnic)
    -   Inspiration for own project: Visualize Covid-19 cases from [this source](https://github.com/CSSEGISandData/COVID-19/tree/master/csse_covid_19_data/csse_covid_19_time_series).

### Block 2: Statistical Modelling: Basic

#### Theory

-   Basics of *modelling*, see [ModernDive Chap. 5.0](https://moderndive.com/5-regression.html), and get the R code [here](http://moderndive.com/scripts/05-regression.R)

    -   What is modelling?
    -   Basic terminology
    -   Prediction vs. explanation

-   Some thoughts on *causal inference*, see ModernDive Chap. 5.3.1

-   *Regression* with one numerical predictor, see ModernDive Chap. 5.1

-   Regression with one categorical predictor, see ModernDive Chap. 5.2

-   Assessing *model fit* (using (adjusted) $R^2$), see ModernDive Chap. 5.3.2

-   For some tips and tricks on typical issues, see [ModernDive tips and tricks](https://moderndive.github.io/moderndive_labs/tips_and_tricks.html)

#### Case study

-   Exercises/Case studies:
    -   Prices of [Boston houses](https://moderndive.com/11-thinking-with-data.html#seattle-house-prices), first part
    -   Modeling [movie succes](https://data-se.netlify.app/2021/02/24/modelling-movie-successes-linear-regression/), first part

### Block 3: Statistical Modelling: Multiple Regression and interaction

#### Theory

-   Slightly more advanced topics on linear regression such as *multiple regression and interaction*, see [ModernDive Chap. 6](https://moderndive.com/6-multiple-regression.html), and get the R code [here](http://moderndive.com/scripts/06-multiple-regression.R)

-   One numerical and one categorical predictor, see ModernDive Chap. 6.1

-   Two numerical predictors, see ModernDive Chap. 6.2

-   Simpson's paradox and more on causal inference, see ModernDive Chap. 6.3.3

#### Case study

-   Exercises/Case studies:
    -   Prices of [Boston houses](https://moderndive.com/11-thinking-with-data.html#seattle-house-prices), second part
    -   Modeling [movie succes](https://data-se.netlify.app/2021/02/24/modelling-movie-successes-linear-regression/), second part
    -   Modeling [flight delays](https://data-se.netlify.app/slides/hands-on-data-exploration/handson-data-workshop_2018-11-21.html#68)

### Block 4: Project coaching

-   This session is dedicated to work on real projects brought in by the students.

-   In addition, open questions regarding the presented concepts are being discussed.

## Instructor

Sebastian Sauer works as a professor at Ansbach university, teaching statistics and related stuff. Analyzing data to answer questions related to social phenomena is one of his major interests. He is trying to help raising the methological (and particularly statistical) skills in the sciences (ie., scientists). The programming language "R" is one of his favorite tools. He sees himself as a learner, and is particularly interested learning more on quantitative approaches to understand nature. Open Science is a hot topic to him. He hopes to contribute to pressing social problems such as populism by bringing in his statistical and psychological know-how. He writes a blog which serves as a sketchpad for stuff in his mind (not immune to thought updates) at https://data-se.netlify.app/. Sebastian is the author of "Moderne Datenanalyse mit R" [@sauer_moderne_2019]. His publication list is available on [Google Scholar](https://scholar.google.de/citations?user=r-2ssnAAAAAJ&hl=en).

## Contact me

Feel free to contact me via email at `sebastiansauer1@gmail.com`.

## Assessment and grades

There is no assessment, there are no grades!

## Talk to me

It's my goal to make this an excellent course and a stimulating and enjoyable experience for all of us. So that I can find out if this is happening, I encourage feedback---be it positive or negative---on all aspects of the course at any time. For example, if something I'm doing is making it difficult for you to learn, then let me know before it's too late; if you particularly enjoyed something we did in class, say so so that we can do it again.

## Course materials

Most of the materials as presented below is made available through the course book [ModernDive](https://moderndive.com/index.html). Please check the relevant chapters of the book before the course to make sure you have all materials available.

## Licence

This is permissive work, [see the licence here](https://github.com/sebastiansauer/stats-nutshell/blob/main/LICENSE).

The author is [Sebastian Sauer](https://sebastiansauer-academic.netlify.app/).

Check out the [Github repo of this project](https://github.com/sebastiansauer/stats-nutshell).

## Resources

### Recommendations

-   [RStudio Cheatsheets](https://rstudio.com/resources/cheatsheets/), particularly on [data wrangling](https://github.com/rstudio/cheatsheets/raw/master/data-transformation.pdf), and [data vizualization](https://github.com/rstudio/cheatsheets/raw/master/data-visualization-2.1.pdf)

-   Book [R for Data Science](https://r4ds.had.co.nz/index.html) as a handy reference or a serious text book.

-   [Tidy Tuesday video series](https://www.youtube.com/results?search_query=tidytuesday)

-   Post your open question on [Stack Overflow](https://stackoverflow.com/).

-   Follow `#rstats` hashtag on [Twitter](https://twitter.com/search?q=%23rstats&src=typed_query).

For students willing to learn more and go deeper (than the concepts explored in the present course), [this book on regression modelling](http://www.stat.columbia.edu/~gelman/arm/), and [this book on statistical learning](http://faculty.marshall.usc.edu/gareth-james/ISL/) are recommended. For German folks, check out my [book on modern data analysis](https://www.springer.com/de/book/9783658215866).

Suggested literature for deepening the analytic skills include [Statistical Rethinking](https://xcelab.net/rm/statistical-rethinking/). For an introduction to graphical causal models, check out [Julia Rohrer's paper](https://journals.sagepub.com/doi/full/10.1177/2515245917745629). For a more in-depth journey, consider reading [this book](https://books.google.de/books/about/Counterfactuals_and_Causal_Inference.html?id=lFTP49c5wJoC&redir_esc=y). While I wholeheartedly recommend such books, we will not be able to discuss many of the ideas presented therein in class (in this course) due to time constraints.

### R Packages {#packages}

All R packages are accessible through the course book; please consult the relevant chapters. Please install all R packages used before the course. [Here's a tutorial](https://moderndive.com/1-getting-started.html#packages) on how to install R packages.

The most important R packages for this course are:

-   tidyverse
-   easystats

The following packages are useful for data access (but not strictly mandatory):

-   gapminder
-   nycflights13
-   fivethirtyeight
-   skimr
-   ISLR

For the Bayes models you'll need some extra software (free, save and stable), but somewhat more hassle to install. Using Bayes in this course is *optional*. You don't miss a lot if you don't use it.

-   rstanarm

For the R package `{rstanarm}` to run, you'll need to [install RStan](https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started). On Windows, this amounts to installing RTools. On Mac, you'll need to install the XCode CLI[^index-2].

[^index-2]: possibly you need also a Fortran compiler, but maybe that's optional

In sum, follow the instructions on the RStan website. It's unfortunately a bit complicated.

### Data

All data are accessible through the course book; please consult the relevant chapters.

### Labs (case studies)

Practical data analysis skills can be practiced using [these labs](https://moderndive.github.io/moderndive_labs/index.html); in addition [Chapter 11](https://moderndive.com/11-thinking-with-data.html) provides two cases studies. Note that such content may be used as homework.

There are a lot of case studies scattered on the internet.

### Sketching causal models

[Dagitty](http://dagitty.net/dags.html) is great tool for sketching causal graphs (DAGs), it can be usd in your browser or as R package. [Here's](dagitty.net/mmxqlaB) an example of a collider bias. Check out [this post](https://data-se.netlify.app/2020/06/04/when-adding-variable-hurts-the-collider-bias/) for an intuitive explanation.

### German introductary course

Readers who speak German may check out this [Blitzkurs](https://sebastiansauer.github.io/r-blitzkurs/) into data analysis using R.

## Where are the slides?

There are none. I feel that slides are not optimal for learning. In class, slides can be detrimental if they are too wordy because that distracts from that the dialogue with the instructor, and I hold this very dialogue as essential. Outside of class, slides are neither helpful. Instead, a good book is much more beneficial, because in a book, there's enough room to patiently explain in sufficient details, an endeavor which is impossible for a slide deck.

To underline my messages to you, dear learners, I will use some sketches on a virtual whiteboard, some interactive apps, live coding, and some (pre-prepared) diagrams. That's a bit similar to what happens at [Khan Academy](https://de.khanacademy.org/). You might have noticed that many courses at [Coursera](https://www.coursera.org/) follow a similar approach.

I readily confess that this approach is novel to many learners in these days, learners who are accustomed to hundreds of Powerpoint slides. Please be open and I think you will appreciate this didactic style.



## Technical Details

Last update: 2023-09-13 08:33:20


::: {.cell layout-align="center" hash='index_cache/html/unnamed-chunk-1_853f1f4c1d8eacb67b6745510041dcf5'}

```{.r .cell-code}
sessioninfo::session_info()
```

::: {.cell-output .cell-output-stdout}
```
─ Session info ───────────────────────────────────────────────────────────────
 setting  value
 version  R version 4.2.1 (2022-06-23)
 os       macOS Big Sur ... 10.16
 system   x86_64, darwin17.0
 ui       X11
 language (EN)
 collate  en_US.UTF-8
 ctype    en_US.UTF-8
 tz       Europe/Berlin
 date     2023-09-12
 pandoc   3.1.1 @ /Applications/RStudio.app/Contents/Resources/app/quarto/bin/tools/ (via rmarkdown)

─ Packages ───────────────────────────────────────────────────────────────────
 package     * version date (UTC) lib source
 cli           3.6.1   2023-03-23 [1] CRAN (R 4.2.0)
 colorout    * 1.2-2   2022-06-13 [1] local
 digest        0.6.33  2023-07-07 [1] CRAN (R 4.2.0)
 evaluate      0.21    2023-05-05 [1] CRAN (R 4.2.0)
 fastmap       1.1.1   2023-02-24 [1] CRAN (R 4.2.0)
 htmltools     0.5.6   2023-08-10 [1] CRAN (R 4.2.0)
 htmlwidgets   1.6.2   2023-03-17 [1] CRAN (R 4.2.0)
 jsonlite      1.8.7   2023-06-29 [1] CRAN (R 4.2.0)
 knitr         1.44    2023-09-11 [1] CRAN (R 4.2.1)
 rlang         1.1.1   2023-04-28 [1] CRAN (R 4.2.0)
 rmarkdown     2.24    2023-08-14 [1] CRAN (R 4.2.0)
 rstudioapi    0.15.0  2023-07-07 [1] CRAN (R 4.2.0)
 sessioninfo   1.2.2   2021-12-06 [1] CRAN (R 4.2.0)
 xfun          0.40    2023-08-09 [1] CRAN (R 4.2.0)

 [1] /Users/sebastiansaueruser/Rlibs
 [2] /Library/Frameworks/R.framework/Versions/4.2/Resources/library

──────────────────────────────────────────────────────────────────────────────
```
:::
:::
