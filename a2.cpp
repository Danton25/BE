#include <iostream>
#include <vector>
#include <omp.h>
#include <sched.h>
#include <time.h>
using namespace std;

void swap(int& a, int& b) {
  int temp = a;
  a = b;
  b = temp;
}

class qs {
 private:
  vector<int> nos;

 public:
  qs(std::vector<int> input) { nos = vector<int>(input); }

  void disp() {
    for (int i = 0; i < nos.size(); i++) {
      cout << nos[i] << "\t";
    }
    cout << endl;
  }

  int partition(int l, int r) {
    int key = nos[l];
    int i = l + 1;
    int j = l;
    while (i <= r) {
      if (nos[i] < key) {
        j++;
    //    swap(nos[i], nos[j]);
      }
      i++;
    }
    swap(nos[j], nos[l]);
    return j;
  }

  void sort() { this->sort(0, nos.size() - 1); }
  void sort(int low, int high) {
    if (low >= high) return;
    int mid = partition(low, high);
	cout<<"Pivot element is "<<nos[mid]<<endl;
    omp_set_nested(1);  // to allow nested threads
	#pragma omp parallel sections
    {
	#pragma omp section
      {
        sort(low, mid - 1);

        cout << "Thread id " << omp_get_thread_num() << " core "
             << sched_getcpu() << endl;
      }

	#pragma omp section
      {
        sort(mid + 1, high);

        cout << "Thread id " << omp_get_thread_num() << " core "
             << sched_getcpu() << endl;
      }
    }
  }
};

int main() {

	clock_t clkStart;
    clock_t clkFinish;
    clkStart = clock();

  cout << "Program for quicksort" << endl;
  vector<int> input;
  cout << "Enter the number of elements" << endl;
  int num;
  cin >> num;
  while (num--) {
    int temp;
   
    cin >> temp;
    input.push_back(temp);
  }
  qs arr = qs(input);
  cout << "Array before sorting \n";
  arr.disp();
  cout << "Array after sorting\n";
  arr.sort();
  arr.disp();
  clkFinish = clock();
  std::cout <<((float) (clkFinish - clkStart)/1000000);

  return 0;
}
